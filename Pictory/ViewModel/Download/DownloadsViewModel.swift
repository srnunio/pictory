//
//  DownloadsViewModel.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import CoreData

@MainActor
class DownloadsViewModel: ObservableObject {
    @Published private var downloads: [PexelDownload] = []
    @Published private var _isBusy: Bool = false
    private var repository: DownloadProtocol = DownloadRepository()
    
    var isBusy: Bool {
        get { _isBusy }
    }
    
    var list: [PexelDownload] {
        get { downloads }
    }
    
    var hasData: Bool {
        get {downloads.count > 0}
    }
    
    func fetch() async{
        _isBusy = true
        
        let downloads = await repository.load()
        
        _isBusy = false
        
        if !downloads.isEmpty { self.downloads = downloads }
    }
    
    func delete(download: PexelDownload, callback: (() -> Void)){
        _isBusy = true
        Task {
            let index = getPosition(download)
            
            let result = await repository.delete(objectId: download.objectId)
            
            _isBusy = false
            
            if result { downloads.remove(at: index) }
        }
        callback()
    }
    
    private func getPosition(_ download: PexelDownload) -> Int {
        return downloads.firstIndex {item in
            return item.objectId == download.objectId
        } ?? -1
    }
}
