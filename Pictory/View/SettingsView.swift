//
//  SettingsView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 28/11/2023.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var model = SettingViewModel()
    
    @ViewBuilder
    func createLabel(title:String, imageName: String) -> some View {
        Label {
            Text(title)
        } icon: {
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section( "downloads".toTranslate) {
                    Toggle(isOn: $model.isLocallyDownload, label: {
                        Label("locally_download".toTranslate, systemImage: "square.and.arrow.down")
                    })
                    .onTapGesture {
                        model.onOrOffLocallyDownload() 
                    }
                }
                .accentColor(.primary) 
            }
            .navigationTitle("settings".toTranslate)
        }
  
    }
}

#Preview {
    SettingsView()
}
