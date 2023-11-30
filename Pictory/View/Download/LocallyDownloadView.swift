//
//  LocallyDownloadView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import SwiftUI

struct LocallyDownloadView: View {
    @StateObject var model: DownloadsViewModel = DownloadsViewModel()
    
    var body: some View {
        VStack{
            List {
                if model.hasData {
                    list
                }else {
                    MessageView(
                        message: "No donwloads",
                        systemName: "arrowshape.down.fill")
                }
            }
        }
        .onAppear {
            model.fetch()
        }
    }
    
    var list: some View {
        ForEach(model.list) { download in
            HStack(spacing: 12) {
                Image(uiImage: download.content!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                    .padding(.horizontal, 2)
                
                VStack (alignment: .leading, spacing: 8) {
                    Text("Download #\(download.objectId)")
                        .font(.subheadline)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Text(download.dateFormatted)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .swipeActions(edge: .trailing,allowsFullSwipe: true) {
                Button {
                    model.delete(download: download)
                } label: {
                    Label("Read", systemImage: "trash")
                }
                .tint(.red)
            }
        }
    }
}

#Preview {
    LocallyDownloadView()
}
