//
//  DownloadHandler.swift
//  Pictory
//
//  Created by Edvaldo Martins on 28/11/2023.
//

import Foundation

final class DownloadHandler {
    private init () {}
    
    static func exists(objectId: Int, onCallback: @escaping ((Bool) -> Void))async -> Void {
          let repository = DownloadRepository()
        Task {
            let result = await repository.isDownloaded(objectId: "\(objectId)")
            onCallback(result)
        }
    }
    
    static func start(photo: PexelPhoto, onCallback: ((Bool) -> Void)?) {
        let saver = PexelsSaver()
        
        saver.download(
            url: photo.originalImage,
            objectId: Int(photo.id),
            saveLocally: SettingPreference.getLocallyDownload(),
            onSuccess: {
                print("onSuccess")
                onCallback?(true)
            },
            onError: { error in
                print("onError")
                onCallback?(false)
            })
    }
}
