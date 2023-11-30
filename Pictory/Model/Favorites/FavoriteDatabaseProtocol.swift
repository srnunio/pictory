//
//  FavoriteDbProtocol.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import SQLite

protocol FavoriteDatabaseProtocol {
    func initialize() async -> Void
    func getConnection() async -> Connection?
    func addToFavorite(objectId: String, url: String) async -> Bool
    func removeToFavorite(objectId: String) async -> Bool
    func isFavorite(objectId: String) async -> Bool
    func fecth() async -> [Favorite]?
}
