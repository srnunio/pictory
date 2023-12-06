//
//  DownloadProtocol.swift
//  Pictory
//
//  Created by Edvaldo Martins on 04/12/2023.
//

import Foundation
import UIKit

protocol DownloadProtocol {
    func load() async ->  [PexelDownload]
    
    func isDownloaded(objectId: String) async ->  Bool
    
    /// MARK: delete download when objectId exist
    func delete(objectId: String) async ->  Bool
    
    func save(objectId: Int, image: UIImage) -> Bool
}
