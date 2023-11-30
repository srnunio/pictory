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
}
 
