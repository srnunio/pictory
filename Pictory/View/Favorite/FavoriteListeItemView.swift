//
//  FavoriteListeItemView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 05/12/2023.
//

import SwiftUI
import CachedAsyncImage

struct FavoriteListeItemView: View {
    var item: Favorite
    
    var body: some View {
        HStack(spacing: 12) {
            CachedAsyncImage(
                url: item.url,
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
                Text("Favorite #\(item.objectId)")
                    .font(.subheadline)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
            }
            Spacer()
        }
    }
}

#Preview {
    FavoriteListeItemView(item: Favorite(id: 102020, objectId: "102020", url: ""))
}
