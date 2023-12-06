//
//  MenuPhotoView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 26/11/2023.
//

import SwiftUI 

struct MenuPhotoView: View {
    @State private var isFavorite: Bool = false
    @State private var isDownloaded: Bool = false
    @Binding  var photo: PexelPhoto
    var onInit: ((Bool) -> Void)?
    var onFavoriteResult: ((Bool) -> Void)?
    var onDownloadResult: ((Bool) -> Void)?
    
    
    private func onCheck() {
        Task {
            await FavoriteHandler.isFavorite(photo: photo){ value in
                print("Check:isFavorite:: \(value)")
                onInit?(value)
            }
        }
    }
    
    private func onAddOrRemove() {
        if !photo.isFavorite {
            FavoriteHandler.add(photo: photo) { value in
                print("Added to favorite? R: \(value)")
                onFavoriteResult?(value)
                isFavorite = value
            }
        } else {
            FavoriteHandler.remove(photo: photo) { value in
                print("Removeded to favorite? R: \(value)")
                onFavoriteResult?(value)
                isFavorite = value
            }
        }
    }
  
    var favoriteActionView: some View {
        let isFavorite = photo.isFavorite
        return Button {
            onAddOrRemove()
        }label: {
            HStack {
                Text((isFavorite ? "remove_favorite" : "favorite").toTranslate)
                Spacer()
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .black)
            }
            .foregroundColor(.black)
        }
    }
    
    var donwloadActionView: some View {
        Button {
            DownloadHandler.start(photo: photo) { value in
                onDownloadResult?(value)
            }
        }
        label: {
            HStack {
                Text("download".toTranslate)
                Spacer()
                Image(systemName: "square.and.arrow.down")
            }
            .foregroundColor(.black)
        }
    }
    
    var body: some View {
        VStack {
            donwloadActionView
            favoriteActionView
        }
        .onAppear {
            print("onAppear")
            onCheck()
        }
    }
}

#Preview {
    MenuPhotoView(photo: .constant(PexelPhoto.mockData))
}
