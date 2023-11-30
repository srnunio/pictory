//
//  DetailsOfPhotoViewModel.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import SwiftUI

@MainActor
class DetailsOfPhotoViewModel: ObservableObject {
    @Published fileprivate var favoriteRespository: FavoriteDatabaseProtocol = FavoriteRepository()
    @Published fileprivate var _isFavorite: Bool = false
    @Published fileprivate var _isDownloading : Bool = false
    
    var isFavorite: Bool {
        get { _isFavorite }
    }
    
    var isDownloading: Bool {
        get { _isDownloading }
    }
    
    init() {
        Task {
            await favoriteRespository.initialize()
        }
    }
    
    func checkIfIsFavorite(id: Int) {
        Task {
            _isFavorite = await favoriteRespository.isFavorite(objectId: String(id))
        }
    }
    
    func addOrRemoveToFavorites(photo: PexelPhoto) {
        if _isFavorite {
            removeToFavorites(Int(photo.id))
        }else{
            addToFavorites(photo)
        }
    }
    
    private func addToFavorites(_ photo: PexelPhoto) {
        Task {
            _isFavorite = await favoriteRespository.addToFavorite(
                objectId: String(photo.id),url: photo.originalImage)
        }
    }
    
    private func removeToFavorites(_ id: Int) {
        Task {
            _isFavorite = await favoriteRespository.removeToFavorite(objectId: String(id))
        }
    }
    
    func downloadImage(photo: PexelPhoto) {
        _isDownloading = true
        let saver = PexelsSaver()
       
        saver.download(
            url: photo.originalImage,
            objectId: Int(photo.id),
            saveLocally: SettingPreference.getLocallyDownload(),
            onSuccess: {
                print("onSuccess")
                self._isDownloading = false
            },
            onError: { error in
                print("onSuccess")
                self._isDownloading = false
            })
    }
}
 
