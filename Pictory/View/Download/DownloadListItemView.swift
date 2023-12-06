//
//  DownloadListItemView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 05/12/2023.
//

import SwiftUI

struct DownloadListItemView: View {
    var item: PexelDownload
    
    var body: some View {
        HStack(spacing: 12) {
            if  item.content != nil {
                Image(uiImage: item.content!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                    .padding(.horizontal, 2)
            }
            
            VStack (alignment: .leading, spacing: 8) {
                Text("Download #\(item.objectId)")
                    .font(.subheadline)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                
                Text(item.dateFormatted)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}
