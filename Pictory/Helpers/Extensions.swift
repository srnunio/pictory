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
}
