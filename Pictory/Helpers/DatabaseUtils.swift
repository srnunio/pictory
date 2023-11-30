//
//  DatabaseUtils.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import SQLite

final class DatabaseUtils {
    static func getConnection(filename: String) -> Connection? {
        do {
            let path = FileUtils.dbPath(filename: filename)
            
            guard path != nil else { return nil }
            
            return try Connection(path!)
        }catch {
            
        }
        return nil
    }
}
