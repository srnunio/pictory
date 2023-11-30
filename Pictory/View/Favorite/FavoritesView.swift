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
            List {
                if model.hasData {
                    list
                }else {
                    MessageView(message: "No favorites",systemName: "star")
                }
            }
        }
        .onAppear {
            model.load()
        }
    }
    
    var list: some View {
        ForEach(model.list) { favorite in
            HStack(spacing: 12) {
                CachedAsyncImage(
                    url: favorite.url,
                    placeholder: {
                        ProgressView()
                    },
                    image: {data in
                        Image(cpImage: data)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                            .padding(.horizontal, 2)
                        
                    },
                    error: { error in
                        Image(systemName: "photo")
                    }
                )
                .padding(.horizontal, 2)
                
                VStack (alignment: .leading, spacing: 8) {
                    Text("Favorite #\(favorite.objectId)")
                        .font(.subheadline)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            .swipeActions(edge: .trailing,allowsFullSwipe: true) {
                Button {
                    //                    model.delete(download: download)
                } label: {
                    Label("Read", systemImage: "trash")
                }
                .tint(.red)
            }
        }
    }
}

#Preview {
    FavoritesView()
}
