//
//  LocallyDownloadView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//

import SwiftUI
import Combine

struct LocallyDownloadView: View {
    @StateObject var model: DownloadsViewModel = DownloadsViewModel()
    @State var selectedToDelete: PexelDownload?
    @State var selectedToOpen: PexelDownload?
    @State var isDeliting: Bool = false
    @State var isOpened: Bool = false
    @State var image = Image("Image")
    
    @Namespace var animation
    
    var onTappedReceiver: ((PexelDownload?) -> Void)?
    
    var body: some View {
        VStack{
            if model.isBusy && !model.hasData {
                ProgressView()
            }else if model.hasData {
                if selectedToOpen != nil && isOpened {
                    GetPhotoView(id: Int(selectedToOpen!.objectId) ?? 0, namespace: animation, showed:$isOpened)
                }else{
                    list
                }
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
                    selectedToDelete = nil
                    isDeliting = false
                }),
                secondaryButton: .destructive(Text("yes"), action: {
                    
                    if selectedToDelete == nil { return }
                    
                    model.delete(download: selectedToDelete!) {
                        selectedToDelete = nil
                    }
                    isDeliting = false
                })
            )
        }
    }
    
    var list: some View {
        ScrollView {
            ForEach(model.list) { download in
                DownloadListItemView(item: download,namespace: animation)
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .cornerRadius(16)
                    .onTapGesture {
                        onTappedReceiver?(download)
                    }
                    .contextMenu {
                        Button {
                            withAnimation {
                                selectedToDelete = download
                                isDeliting = true
                            }
                        } label: {
                            Label(
                                title: { Text("delete".toTranslate) },
                                icon: { Image(systemName: "trash") }
                            )
                        }
                        ShareLink(
                            item: Image(uiImage: download.content!),
                            preview: SharePreview(
                                "Download #\(download.objectId)",
                                image: Image(uiImage: download.content!)
                            )
                        ) {
                            Label("share".toTranslate, systemImage:  "square.and.arrow.up")
                        }
                    }
            }
        }
    }
}

#Preview {
    LocallyDownloadView()
}
