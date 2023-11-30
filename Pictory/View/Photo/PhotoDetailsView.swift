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
    
    var namespace: Namespace.ID
    
    var closeButton: some View {
        Button { onClose() }
        label: {
            Image(systemName: "plus")
                .padding(16)
                .background(.ultraThinMaterial, in: Circle())
                .shadow(color: .secondary ,radius: 4)
        }
        .rotationEffect(.init(degrees: 45))
        .padding(.leading)
        
    }
    
    var favoriteButton: some View {
        Button {
            model.addOrRemoveToFavorites(photo: photo)
        }
        label: {
            Image(systemName: model.isFavorite ? "heart.fill" : "heart")
                .padding(16)
                .background(
                    Circle().fill(.ultraThinMaterial))
                .foregroundColor(model.isFavorite ? .red : .primary)
                .shadow(color: .secondary ,radius: 4)
        }
    }
    
    var downloadButton: some View {
        Button { model.downloadImage(photo: photo )}
        label: {
            if model.isDownloading {
                ProgressView()
                    .padding(14)
                    .background(Circle().fill(.ultraThinMaterial))
            }else{
                Image(systemName: "square.and.arrow.down")
                    .padding(16)
                    .background(Circle().fill(.ultraThinMaterial))
                    .shadow(color: .secondary ,radius: 4)
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
                    Spacer()
                    downloadButton.padding(.trailing, 16)
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
