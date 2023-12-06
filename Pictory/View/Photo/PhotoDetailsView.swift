//
//  PhotoDetailsView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 26/11/2023.
//

import SwiftUI
import CachedAsyncImage

 

struct PhotoDetailsView: View {
    
    @Binding var showed: Bool
    @Binding var photo: PexelPhoto
    @StateObject var model = DetailsOfPhotoViewModel()
    @State var stateValue: Bool = false
    @State var downloadedAction: Bool = false
    @State var favoriteAction: Bool = false
    
    var namespace: Namespace.ID
    
    var x: some View {
        Circle().background(Circle().fill(.orange))
    }
    
    var closeButton: some View {
        Button { onClose() }
        label: {
            Image(systemName: "plus")
                .padding(16)
                .background(.ultraThinMaterial, in: Circle()) 
        }
        .rotationEffect(.init(degrees: 45))
        .padding(.leading)
        
    }
    
    var favoriteButton: some View {
        Button {
            model.addOrRemoveToFavorites(photo: photo) {value in
                stateValue = !value;
                favoriteAction = true;
                downloadedAction = false;
            }
        }
        label: {
            VStack {
                if model.isFavorite {
                    Image(systemName: "heart.fill" )
                        .padding(16)
                        .background(Circle().fill(.red))
                } else    {
                    Image(systemName: "heart")
                        .padding(16)
                        .background(Circle().fill(.ultraThinMaterial))
                }
                
            } .foregroundColor(model.isFavorite ? .white : .primary)
        }
    }
    
    var downloadButton: some View {
        Button { 
            model.downloadImage(photo: photo) { value in
                stateValue = !value;
                favoriteAction = false;
                downloadedAction = true;
            }
        }
        label: {
            if model.isDownloading {
                ProgressView()
                    .padding(14)
                    .background(Circle().fill(.ultraThinMaterial))
            }else{
                Image(systemName: "square.and.arrow.down")
                    .padding(16)
                    .background(Circle().fill(.ultraThinMaterial))
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            Color.clear.background(.ultraThinMaterial).ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    closeButton
                    Spacer()
                    favoriteButton
                        .padding(.horizontal, model.isDownloaded ? 16 : 0)
                    if !model.isDownloaded {
                        downloadButton.padding(.horizontal, 16)
                    }
                }
                .foregroundColor(.primary)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
            VStack(spacing: 0) {
                CachedAsyncImage(
                    url: photo.largeImage,
                    placeholder: {
                        ProgressView()
                    },
                    image: {data in
                        Image(cpImage: data)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .frame(
                                maxWidth: CGFloat(photo.width),
                                maxHeight: CGFloat(photo.height))
                            
                    },
                    error: { error in
                        Text(error)
                    }
                )
                .matchedGeometryEffect(id: "\(photo.id)", in: namespace)
                .padding()
                .onTapGesture { onClose() }
            }
        }
        .onAppear {
            TemporaryImageCache.shared.setCacheLimit(
                countLimit: 1000,
                totalCostLimit: 1024 * 1024 * 50
            )
            model.checkIfIsFavorite(id: Int(photo.id))
            model.checkIfIsDownloaded(id: Int(photo.id))
        }
        .overlay(alignment: .center) {
            if favoriteAction {
                FavoriteReactionView(
                    state: $stateValue,
                    reaction: $favoriteAction)
                .padding()
                .background(Color.clear.background(.ultraThinMaterial))
                .cornerRadius(16.0)
            }
        }
        .overlay(alignment: .center) {
            if downloadedAction {
                DownloadReactionView(
                    state: $stateValue,
                    reaction: $downloadedAction)
                .padding()
                .background(Color.clear.background(.ultraThinMaterial))
                .cornerRadius(16.0)
            }
        }
    }
    
    private func onClose() {
        withAnimation { showed = false }
    }
}

#Preview {
    @Namespace var namespace
    return PhotoDetailsView(
        showed: .constant(true),
        photo: .constant(PexelPhoto.mockData),
        namespace: namespace)
}
