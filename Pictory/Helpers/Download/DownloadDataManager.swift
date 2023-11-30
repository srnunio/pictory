//
//  DownloadDataManager.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import CoreData

final class DownloadDataManager {
    let persistent: NSPersistentContainer
    static let instance: DownloadDataManager = DownloadDataManager()
    
    private init( ) {
        ValueTransformer.setValueTransformer(DownloadTransformer(), forName: NSValueTransformerName("DownloadTransformer"))
        persistent = NSPersistentContainer(name: "DownloadPexelsModel")
        persistent.loadPersistentStores { desc, err in
            if let error = err {
                fatalError("Not possible in DownloadDataManager \(error)")
            }
        }
    }
}
