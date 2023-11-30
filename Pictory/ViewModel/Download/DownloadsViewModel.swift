//
//  DownloadsViewModel.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import CoreData

class DownloadsViewModel: ObservableObject {
    @Published private var downloads: [PexelDownload] = []
    private var context = DownloadDataManager.instance.persistent.viewContext
    
    var list: [PexelDownload] {
        get { downloads }
    }
    
    var hasData: Bool {
        get {downloads.count > 0}
    }
    
    func fetch() {
        let request = NSFetchRequest<PexelDownload>(entityName: "PexelDownload")
        do {
            let downloads = try context.fetch(request)
            
            if !downloads.isEmpty {
                self.downloads = downloads
            }
        }catch {
            
        }
    }
    
    func delete(download: PexelDownload) {
        let index = getPosition(download)
        context.delete(download)
        do {
            try context.save()
            downloads.remove(at: index)
        }catch { }
    }
    
    private func getPosition(_ download: PexelDownload) -> Int {
        return downloads.firstIndex {item in
            return item.objectId == download.objectId
        } ?? -1
    }
}
