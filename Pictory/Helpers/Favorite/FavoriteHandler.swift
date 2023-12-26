//
//  FavoriteHandler.swift
//  Pictory
//
//  Created by Edvaldo Martins on 28/11/2023.
//

import Foundation

class FavoriteHandler {
    private init () {}
    static fileprivate var repository: FavoriteDatabaseProtocol = FavoriteRepository()
    
    static func isFavorite(photo:PexelPhoto, callback: ((Bool) -> Void)?) async -> Void{
        Task {
            callback?(await repository.isFavorite(objectId:  String(photo.id)))
        }
    }
    
    static func remove(photo:PexelPhoto, callback: ((Bool) -> Void)?) {
        Task {
            callback?(await repository.removeToFavorite(objectId: String(photo.id)))
        }
    }
    
    static func add(photo:PexelPhoto, callback: ((Bool) -> Void)?) {
        Task {
            callback?(await repository.addToFavorite(objectId: String(photo.id), url: photo.originalImage))
        }
    }
}
