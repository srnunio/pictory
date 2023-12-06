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
    @State var isDeliting: Bool = false
    @State var selectedItem: Favorite?
    
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
        .alert(isPresented: $isDeliting) {
            Alert(
                title: Text("delete"),
                message: Text("delete_download_warning"),
                primaryButton: .cancel(Text("no"), action: {
                    onSelect(nil)
                }),
                secondaryButton: .destructive(
                    Text("yes"),
                    action: {
                        
                        if selectedItem == nil { return }
                        
                        model.delete(selectedItem) {
                            onSelect(nil)
                        }
                    }
                )
            )
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
                            onSelect(favorite)
                        } label: {
                            Text("delete".toTranslate)
                        }
                    }
            }
        }
    }
    
    private func onSelect(_ favorite: Favorite?) {
        withAnimation {
            selectedItem = favorite
            isDeliting = favorite != nil
        }
    }
}

#Preview {
    FavoritesView()
}
