//
//  MenuPhotoView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 26/11/2023.
//

import SwiftUI

struct MenuPhotoView: View {
    @Binding var photo: PexelPhoto
    var onCallback: ((Bool) -> Void)?
    
    
    private func onCheck() {
        Task {
            await FavoriteHandler.isFavorite(photo: photo){ value in
                print("Check:isFavorite:: \(value)")
                onCallback?(value)
            }
        }
    }
    
    private func onAddOrRemove() {
        if !photo.isFavorite {
            FavoriteHandler.add(photo: photo) { value in
                print("Added to favorite? R: \(value)")
                onCallback?(value)
            }
        } else {
            FavoriteHandler.remove(photo: photo) { value in
                print("Removeded to favorite? R: \(value)")
                onCallback?(value)
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
            DownloadHandler.start(photo: photo)
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
