//
//  DownloadHandler.swift
//  Pictory
//
//  Created by Edvaldo Martins on 28/11/2023.
//

import Foundation

final class DownloadHandler {
    private init () {}
    private var context = DownloadDataManager.instance.persistent.viewContext
    
    static func start(photo: PexelPhoto) {
        let saver = PexelsSaver()
        
        saver.download(
            url: photo.originalImage,
            objectId: Int(photo.id),
            saveLocally: SettingPreference.getLocallyDownload(),
            onSuccess: {
                NotificationUtils.show(message: "\("download_sucessfully".toTranslate)", title: "Download")
                print("onSuccess")
            },
            onError: { error in
                NotificationUtils.show(message: "\("download_failure".toTranslate)", title: "Download")
                print("onError")
            })
    }
}
