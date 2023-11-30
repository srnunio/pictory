//
//  DownloadTransformer.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import UIKit

class DownloadTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let data = value as? UIImage else { return nil }
        
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
        }catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        do {
            guard let data = value as? Data else { return nil } 
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
        }catch { return nil}
    }
}
