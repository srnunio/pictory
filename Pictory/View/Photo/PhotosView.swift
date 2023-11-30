//
//  PhotosView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 25/11/2023.
//

import SwiftUI
import CachedAsyncImage
import WaterfallGrid 



struct PhotosView: View {
    @State var columns: Double = 3.0
    @State var scrollValue: CGFloat = 0
    @Binding var openedDetail: Bool
    @StateObject var model: PhotosViewModel = PhotosViewModel()
    var animation: Namespace.ID
    
    var onTappedReceiver: ((PexelPhoto?) -> Void)?
    
    @ViewBuilder
    func PexelPhotoView (photo: PexelPhoto, cornerRadius: Double = 10) -> some View {
        VStack(spacing: 0){
            CachedAsyncImage(
                url: photo.mediumImage,
                placeholder: { ProgressView() },
                image: {data in
                    Image(cpImage: data)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(cornerRadius)
                },
                error: { err in
                    MessageView(message: "\(err)", systemName: "photo").background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(.gray.opacity(0.2))
                    )
                }
            )
            .matchedGeometryEffect(id: "\(photo.id)", in: animation)
        }
    }
    
    @ViewBuilder
    func WaterfallGridView() -> some View{
        ScrollView(.vertical,showsIndicators: false){
            WaterfallGrid(model.list) { photo in
                PexelPhotoView(photo: photo)
//                    .onLongPressGesture {
//                        Task {
//                            FavoriteHandler.isFavorite(photo: photo, callback: { value in
//                                model.update(photo.copyWith(isFavorite: value))
//                            })
//                        }
//                    }
                    .onTapGesture {
                        onTapped(photo: photo)
                    }
                    .contextMenu  {
                        MenuPhotoView(photo: .constant(photo)){ value in
                            print("update photo \(photo.id) -> \(value)")
                            model.updateFavoriteValue(photo, value)
                        }
                    }
                
                    
            }
            .scrollOptions(direction: .vertical)
            .gridStyle(
                columnsInPortrait: Int(columns),
                columnsInLandscape: 3,
                animation: .easeInOut(duration: 0.24)
            )
            scrollDetection
        }
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(
                key: ScrollPreferenceKeys.self,
                value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(
            ScrollPreferenceKeys.self,
            perform: { value in
                withAnimation(.easeInOut){
                    scrollValue = CGFloat(value)
                }
            })
    }
    
    var body: some View {
         
          ZStack {
            VStack(spacing: 0){
                if model.isBusy && !model.hasData {
                    ProgressView()
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                } else if !model.isBusy && !model.hasData {
                    MessageView(message: "Photos not found")
                }
                else{
                    WaterfallGridView()
                }
            }
            .opacity(openedDetail ? 0 : 1)
            .padding(.horizontal)
            .onAppear {
                TemporaryImageCache.shared.setCacheLimit(
                    countLimit: 1000,
                    totalCostLimit: 1024 * 1024 * 50
                )
                model.load()
            }
            .overlay(alignment: .bottom) {
                if !openedDetail {
                    ControllerSettingView(
                        isBusy: .constant(model.isBusy),
                        columns: $columns,
                        currentPage: .constant(model.currentPage),
                        totalPage: .constant(model.totalPage),
                        onNext: model.hasNext ? { model.onNext() } : nil,
                        onPrevious: model.hasPrevious ? { model.onPrevious() } : nil
                    )
                    .cornerRadius(24)
                    .padding(.horizontal, 30)
                    .ignoresSafeArea()
                }
            }
            .overlay(alignment: .center) {
                if model.isBusy {
                    ProgressView()
                        .padding()
                        .frame(width: 100,height: 100)
                        .background(Color.clear.background(.ultraThinMaterial))
                        .cornerRadius(16.0)
                }
            }
            .refreshable {
                if !model.isBusy { model.load(refresh: true) }
            }
        }
    }
    
    // MARK: select and open card details
    func onTapped(photo: PexelPhoto?) {
        onTappedReceiver?(photo)
    }
}

#Preview {
    @Namespace var animation
    return PhotosView(
        columns: 3,
        openedDetail: .constant(false),
        animation: animation)
}
