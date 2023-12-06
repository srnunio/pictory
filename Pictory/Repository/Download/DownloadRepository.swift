//
//  DownloadRepository.swift
//  Pictory
//
//  Created by Edvaldo Martins on 04/12/2023.
//

import Foundation
import CoreData
import UIKit

class DownloadRepository: DownloadProtocol {
    
    private var context = DownloadDataManager.instance.persistent.viewContext
    
    func save(objectId: Int, image: UIImage) -> Bool {
        do {
            let download = PexelDownload(context: self.context)
            download.objectId = "\(objectId)"
            download.date = Date.now
            download.content = image
            try self.context.save()
            return true
        }catch {
            return false
        }
    }
    
    func load() async -> [PexelDownload] {
        let request = NSFetchRequest<PexelDownload>(entityName: "PexelDownload")
       
        request.sortDescriptors = [NSSortDescriptor(keyPath: \PexelDownload.date, ascending: false)]
       
        do {
            let downloads = try context.fetch(request)
            
            if !downloads.isEmpty { return downloads }
            
            return []
        }catch {
            return []
        }
    }
    
    func isDownloaded(objectId: String) async -> Bool {
        let request = NSFetchRequest<PexelDownload>(entityName: "PexelDownload")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "objectId == %@", objectId)
        do {
            let downloads = try context.fetch(request)
            return !downloads.isEmpty
        }catch {
            return false
        }
    }
    
    func delete(objectId: String) async -> Bool {
        let request = NSFetchRequest<PexelDownload>(entityName: "PexelDownload")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "objectId == %@", objectId)
        do {
            let download = try context.fetch(request).first
            if download != nil {
                context.delete(download!)
                try context.save()
                return true
            }
            return false
        }catch {
            return false
        }
    }
    
}
