//
//  ButtonAction.swift
//  Pictory
//
//  Created by Edvaldo Martins on 06/12/2023.
//

import SwiftUI

struct ButtonAction: View {
    var systemName: String
    var onTap: (() -> Void)?
    
    var body: some View {
        Button { onTap?()  }
        label: {
            Image(systemName: systemName)
                .padding(16)
                .background(.ultraThinMaterial, in: Circle())
        }
        .padding(.leading)
    }
}

#Preview {
    ButtonAction(systemName: "plus")
}
