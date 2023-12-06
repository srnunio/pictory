//
//  DownloadReaction.swift
//  Pictory
//
//  Created by Edvaldo Martins on 04/12/2023.
//

import SwiftUI

struct DownloadReactionView: View {
    @Binding var state: Bool
    @Binding var reaction: Bool
    @State var value: Bool? = nil 
    
    var body: some View {
        VStack {
            ReactionView(
                state: $state,
                reaction: $reaction,
                positiveFigure: "arrowshape.down.fill",
                negativeFigure: "arrowshape.down",
                positiveMessage: "",
                negativeMessage: "",
                color: .black
            )
        }
    }
}

#Preview {
    DownloadReactionView(
        state: .constant(false),
        reaction: .constant(false)
    )
}


 
