//
//  FileUtils.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import UIKit

final class FileUtils { 
    static func dbPath(filename: String) -> String? {
        var url: URL?
        do {
            url = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
        }catch {
            print("dbPath => \(error)")
        }
        
        return url != nil ? url!.appendingPathComponent("\(filename).sqlite").path() : nil
    }
}
