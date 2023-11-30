//
//  Download.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import CoreData
import UIKit

@objc(PexelDownload)
class PexelDownload: NSManagedObject {
    @NSManaged public var date: String
    @NSManaged public var content: UIImage?
    @NSManaged public var objectId: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PexelDownload> {
        return NSFetchRequest<PexelDownload>(entityName: "PexelDownload")
    }
}

extension PexelDownload: Identifiable {
    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:MM"
        return formatter.string(from: Date.parse(date) ?? Date())
    }
}
