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
    @Published fileprivate var downloadRepository: DownloadProtocol = DownloadRepository()
    @Published fileprivate var _isFavorite: Bool = false
    @Published fileprivate var _isDownloaded: Bool = false
    @Published fileprivate var _isDownloading : Bool = false
    
    var isFavorite: Bool {
        get { _isFavorite }
    }
    
    var isDownloaded: Bool {
        get { _isDownloaded }
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
    
    func checkIfIsDownloaded(id: Int) {
        Task {
            _isDownloaded = await downloadRepository.isDownloaded(objectId: String(id))
        }
    }
    
    func addOrRemoveToFavorites(photo: PexelPhoto, callback: @escaping ((Bool) -> Void)) {
        if _isFavorite {
            removeToFavorites(Int(photo.id),callback: callback)
        }else{
            addToFavorites(photo,callback: callback)
        }
    }
    
    private func addToFavorites(_ photo: PexelPhoto, callback: @escaping ((Bool) -> Void)) {
        Task {
            _isFavorite = await favoriteRespository.addToFavorite(
                objectId: String(photo.id),url: photo.originalImage)
            callback(_isFavorite)
        }
    }
    
    private func removeToFavorites(_ id: Int, callback: @escaping ((Bool) -> Void)) {
        Task {
            _isFavorite = await favoriteRespository.removeToFavorite(objectId: String(id))
            callback(_isFavorite)
        }
    }
    
    func downloadImage(photo: PexelPhoto,  callback: @escaping ((Bool) -> Void)) {
        _isDownloading = true
        let saver = PexelsSaver()
        
        saver.download(
            url: photo.originalImage,
            objectId: Int(photo.id),
            saveLocally: SettingPreference.getLocallyDownload(),
            onSuccess: {
                print("onSuccess")
                self._isDownloading = false
                self._isDownloaded = true
                callback(true)
            },
            onError: { error in
                print("onError")
                self._isDownloading = false
                self._isDownloaded = false
                callback(false)
            })
    }
}
 
