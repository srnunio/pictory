//
//  FavoritesViewModel.swift
//  Pictory
//
//  Created by Edvaldo Martins on 28/11/2023.
//

import SwiftUI

@MainActor
class FavoritesViewModel: ObservableObject {
    private var db: FavoriteDatabaseProtocol = FavoriteRepository()
    @Published private var favorites: [Favorite] = []
    
    
    var hasData: Bool {
        get { list.count > 0 }
    }
    
    var list: [Favorite] {
        get { favorites }
    }
    
    init() {
        Task {
            await db.initialize()
        }
    }
    
    func load(refresh: Bool = false) {
        Task {
            
            let result = await db.fecth()
            
            guard result != nil else { return }
            
            self.favorites = result!
        }
    }
    
    
    func delete(_ favorite: Favorite?, callback: (() -> Void)) {
        if favorite == nil { return }
        
        let index = getPosition(favorite!)
        
        guard index >= 0 else { return }
        
        Task {
            
            let result = await db.removeToFavorite(objectId: favorite!.objectId)
            
            guard !result else { return }
            
            self.favorites.remove(at: index)
        }
        
        callback()
    }
    
    private func getPosition(_ favorite: Favorite) -> Int {
        return favorites.firstIndex {item in
            return item.objectId == favorite.objectId
        } ?? -1
    }
}
 
