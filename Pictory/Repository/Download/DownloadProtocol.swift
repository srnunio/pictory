//
//  DownloadProtocol.swift
//  Pictory
//
//  Created by Edvaldo Martins on 04/12/2023.
//

import Foundation
import UIKit

protocol DownloadProtocol {
    // MARK: browse all downloads
    func load() async ->  [PexelDownload]
    
    // MARK: verify if has download with [objectId]
    func isDownloaded(objectId: String) async ->  Bool
    
    // MARK: delete download when objectId exist
    func delete(objectId: String) async ->  Bool
    
    func save(objectId: Int, image: UIImage) -> Bool
}
