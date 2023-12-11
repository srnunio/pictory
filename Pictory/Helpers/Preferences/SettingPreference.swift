//
//  SettingPreference.swift
//  Pictory
//
//  Created by Edvaldo Martins on 28/11/2023.
//

import Foundation

final class SettingPreference {
    private init () {}
    
    static func setLocallyDownload(_ value: Bool) {
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: "LocallyDownload")
        let synchronize = preferences.synchronize()
        print("\(synchronize)")
    }
    
    static func setLocale(_ value: String) {
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: "Locale")
        preferences.synchronize() 
    }
    
    
    static func getLocallyDownload() -> Bool {
        let preferences = UserDefaults.standard
        return preferences.bool(forKey:  "LocallyDownload")
    }
    
    static func getLocale() -> String {
        let preferences = UserDefaults.standard
        return preferences.string(forKey:  "Locale") ?? Constants.defaultLocale
    }
    
    static func onLoad(onValues: ((_ locale: String,_ locallyDownload: Bool) -> Void))  {
        let locale = getLocale()
        let locallyDownload = getLocallyDownload()
        onValues(locale,locallyDownload)
    }
}
