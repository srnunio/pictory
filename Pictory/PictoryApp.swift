//
//  PictoryApp.swift
//  Pictory
//
//  Created by Edvaldo Martins on 24/11/2023.
//

import SwiftUI
import UIKit

@main
struct PictoryApp: App{
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UNUserNotificationCenter.current().requestAuthorization(
                        options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("Permission approved!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
//                .onAppear {
//                    Bundle.setLanguage(SettingPreference.getLocale())
//                }
//                .environment(\.locale,.init(identifier: SettingPreference.getLocale()))
        }
    }
}
