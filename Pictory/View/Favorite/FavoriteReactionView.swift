//
//  FavoriteReactionView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 04/12/2023.
//

import SwiftUI

struct FavoriteReactionView: View {
    @Binding var state: Bool
    @Binding var reaction: Bool
    @State var value: Bool? = nil 
    
    var body: some View {
        VStack {
            ReactionView(
                state: $state,
                reaction: $reaction,
                positiveFigure: "heart.fill",
                negativeFigure: "heart",
                positiveMessage: "",
                negativeMessage: "", 
                color: .red
            )
        }
    }
}

#Preview {
    FavoriteReactionView(state: .constant(false), reaction: .constant(false))
}
