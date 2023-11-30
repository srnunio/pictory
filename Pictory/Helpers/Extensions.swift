//
//  Extensions.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import Foundation
import SwiftUI

extension Date {
    static func parse(_ value: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return formatter.date(from: value)
    }
}

extension String {
    
    var toTranslate: String {
        let defaultLanguage = SettingPreference.getLocale()
        let value = NSLocalizedString(self, comment: "")
        if value != self || NSLocale.preferredLanguages.first == defaultLanguage {
            return value
        }
        guard let path = Bundle.main.path(forResource: defaultLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return "**\(value)**"
        }
        
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
    
//    var toTranslate: String {
//        return self
////        let path = Bundle.main.path(forResource: "pt", ofType: "strings")
////             let bundle = Bundle(path: path!)
////             return NSLocalizedString(self, tableName: nil, bundle: bundle!,
////             value: "", comment: "")
//    }
//    var toTranslate: LocalizedStringKey {
//        get {
//            return LocalizedStringKey(self)
//        }
//    }
    
    
}

//extension LocalizedStringKey {
//    var toString: String {
//    }
//}
