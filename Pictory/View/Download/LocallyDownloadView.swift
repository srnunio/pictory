//
//  LocallyDownloadView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import SwiftUI

struct LocallyDownloadView: View {
    @StateObject var model: DownloadsViewModel = DownloadsViewModel()
    @State var forDelete: PexelDownload?
    @State var isDeliting: Bool = false
    
    var body: some View {
        VStack{
            if model.isBusy && !model.hasData {
                ProgressView()
            }else if model.hasData {
                list
            }else {
                MessageView(
                    message: "no_downloads".toTranslate,
                    systemName: "arrowshape.down.fill")
            }
        }
        .task {
            await model.fetch()
        }
        .alert(isPresented: $isDeliting) {
            Alert(
                title: Text("delete"),
                message: Text("delete_download_warning"),
                primaryButton: .cancel(Text("no"), action: {
                    forDelete = nil
                    isDeliting = false
                }),
                secondaryButton: .destructive(Text("yes"), action: {
                    
                    if forDelete == nil { return }
                    
                    model.delete(download: forDelete!) {
                        forDelete = nil
                    }
                    isDeliting = false
                })
            )
        }
    }
    
    var list: some View {
        ScrollView {
            ForEach(model.list) { download in
                DownloadListItemView(item: download)
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .cornerRadius(16)
                    .contextMenu {
                        Button {
                            withAnimation {
                                forDelete = download
                                isDeliting = true 
                            }
                        } label: {
                            Text("delete".toTranslate)
                        }
                    }
            }
        }
    }
}

#Preview {
    LocallyDownloadView()
}
