//
//  FavoriteRepository.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import SQLite

class FavoriteRepository: FavoriteDatabaseProtocol {
   
    fileprivate let table = Table("favorites")
    fileprivate let idField = Expression<Int64>("id")
    fileprivate let objectIdField = Expression<String>("objectId")
    fileprivate let objectUrlField = Expression<String>("url")
    
    func initialize() async {
        let db = await getConnection()
        
        guard db != nil else { return }
        
        do {
            try db?.run(table.create(ifNotExists: true){ myTable in
                myTable.column(idField, primaryKey: .autoincrement)
                myTable.column(objectIdField, unique: true)
                myTable.column(objectUrlField)
            })
        }catch {
            print("FavoriteDatabaseProtocol:initialize:: \(error)")
        }
    }
    
    func getConnection() async -> SQLite.Connection? {
        return DatabaseUtils.getConnection(filename: Constants.dataBaseName)
    }
    
    func addToFavorite(objectId: String,url: String) async -> Bool {
        do {
            let db = await getConnection()
            
            guard db != nil else { return false }
            
            let result = try db!.run(table.insert(objectIdField <- objectId,objectUrlField <- url))
            
            return result > 0
        }catch {
            print("FavoriteDatabaseProtocol:addToFavorite:: \(error)")
        }
        return false
    }
    
    func removeToFavorite(objectId: String) async -> Bool {
        do {
            let db = await getConnection()
            
            guard db != nil else { return false }
            
            let result = try db!.run(table.filter(objectIdField == objectId).delete())
            
            print("result:: \(result)")
            
            return false
        } catch {
            print("FavoriteDatabaseProtocol:isFavorite:: \(error)")
        }
        return false
    }
    
    func isFavorite(objectId: String) async -> Bool {
        do {
            let db = await getConnection()
            
            guard db != nil else { return false }
            
            let query = table.filter(objectIdField == objectId)
                .limit(1)
            
            var count = 0
            
            for _ in try db!.prepare(query) { count += 1 }
            
            print("result:: \(count)")
           
            return count > 0
        } catch {
            print("FavoriteDatabaseProtocol:isFavorite:: \(error)")
        }
        return false
    }
    
    func fecth() async -> [Favorite]? {
        do {
            let connection = await getConnection()
            guard connection != nil else { return nil }
            
            let query = table.select(
                idField,
                objectIdField,
                objectUrlField
            ).order(idField.desc, idField)
            
            var favorites: [Favorite] = []
            
            for row in try connection!.prepare(query) {
                favorites.append(parseRowToFavorite(row))
            }
            
            return favorites
            
        }catch { print("fecth failure \(error)") }
        
        return nil
    }
    
    
    private func parseRowToFavorite (_ row: Row) -> Favorite {
        return Favorite(
            id: row[idField],
            objectId: row[objectIdField],
            url: row[objectUrlField])
    }
}
