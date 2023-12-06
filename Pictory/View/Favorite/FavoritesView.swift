//
//  FavoritesView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 28/11/2023.
//

import SwiftUI
import CachedAsyncImage

struct FavoritesView: View {
    @StateObject var model: FavoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        VStack{
            if model.hasData {
                list
            }else {
                MessageView(
                    message: "no_favorites".toTranslate,
                    systemName: "star")
            }
        }
        .onAppear {
            model.load()
        }
    }
    
    var list: some View {
        ScrollView {
            ForEach(model.list) { favorite in
                FavoriteListeItemView(item: favorite)
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .cornerRadius(16)
                    .contextMenu {
                        Button { 
                        } label: {
                            Text("delete".toTranslate)
                        }
                    }
            }
        }
    }
}

#Preview {
    FavoritesView()
}
