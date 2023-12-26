//
//  MessageView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import SwiftUI

struct MessageView: View {
    var message: String
    var systemName: String = "info.bubble"

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45)
            Text(message)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(minHeight: 100)
    }
}

#Preview {
    MessageView(message: "File not found, please try again!")
}
