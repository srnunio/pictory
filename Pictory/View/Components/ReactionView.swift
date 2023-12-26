//
//  ReactionView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 04/12/2023.
//

import SwiftUI

struct  ReactionView: View {
    @Binding var state: Bool
    @Binding var reaction: Bool
    @State var value: Bool? = nil
    @State var dance: Bool = true
    var positiveFigure: String
    var negativeFigure: String
    var positiveMessage: String
    var negativeMessage: String
    var color: Color
    
    var body: some View {
        let reactionValue = (value != nil ) ? value! : state
        
        VStack {
            Image(systemName: reactionValue ? positiveFigure : negativeFigure)
                .resizable()
                .frame(width: 90,height: 80)
                .foregroundColor(reactionValue ? color : .primary)
                .rotationEffect(.init(degrees: dance ? 45 : 0))
            
            Text(reactionValue ? positiveMessage : negativeMessage)
        }
        .onAppear {
            onReaction()
        }
    }
    
    func onReaction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.bouncy(duration: 0.35)) {
                value = !state
                dance = false
                state = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation(.bouncy(duration: 0.50)) {
                        reaction = false
                    }
                }
                
            }
        }
    }
    
}

#Preview {
    ReactionView(state: .constant(false),
                 reaction: .constant(false),
                 positiveFigure: "arrowshape.down.fill",
                 negativeFigure: "arrowshape.down",
                 positiveMessage: "download_sucessfully".toTranslate,
                 negativeMessage: "download_failure".toTranslate,
                 color: .black)
}
