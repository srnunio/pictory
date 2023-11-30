//
//  SettingViewModel.swift
//  Pictory
//
//  Created by Edvaldo Martins on 28/11/2023.
//

import SwiftUI

@MainActor
class SettingViewModel: ObservableObject {
    @Published var isLocallyDownload: Bool = false
    @Published private var localeCode: String = "pt_PT"
    
    var isPortuguesse: Bool {
        localeCode == "pt_PT"
    }
    
    var isEnglish: Bool {
        localeCode == "en_US"
    }
    
    init() {
        onLoad()
    }
    
    
    private func onLoad() {
        SettingPreference.onLoad { localeCode, isLocallyDownload in
            self.localeCode = localeCode
            self.isLocallyDownload = isLocallyDownload
            languageButtonAction(localeCode: localeCode)
        }
    }
    
    func onOrOffLocallyDownload() {
        SettingPreference.setLocallyDownload(!isLocallyDownload)
        isLocallyDownload = !isLocallyDownload
    }
    
    func enbalePTLanguage() {
        SettingPreference.setLocale("pt_PT")
        localeCode = "pt_PT"
        languageButtonAction(localeCode:  "pt_PT")
    }
    
    func enbaleUSLanguage() {
        SettingPreference.setLocale("en_US")
        localeCode = "en_US"
        languageButtonAction(localeCode: "en_US")
    }
    
    private func languageButtonAction(localeCode: String) {
        print("UNMutableNotificationContent")
        NotificationUtils.show()
    }
}
 


 
