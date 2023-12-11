//
//  GetPhotoView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 06/12/2023.
//

import SwiftUI
import CachedAsyncImage

struct GetPhotoView: View {
    var id: Int
    var namespace: Namespace.ID
    @Binding var showed: Bool
    @StateObject var model = GetPhotoViewModel()
    
    var onDelete: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.clear.background(.ultraThinMaterial).ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    ButtonAction(systemName: "plus") { onClose() }
                        .rotationEffect(.init(degrees: 45))
                    Spacer()
//                    ButtonAction(systemName: "trash") {
//                        onDelete?()
//                    }
//                    .padding(.horizontal, 16.0)
                }
                .foregroundColor(.primary)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
            
            VStack {
                if model.isBusy {
                    ProgressView()
                }
                else if model.hasError {
                    MessageView(message: labelOfError())
                }
                else if !model.hasData {
                    MessageView(message: "notfound".toTranslate)
                }else {
                    ImageView(photo: model.photo)
                }
            } 
            .onAppear {
                model.load(id: id)
            }
        }
    }
    
    @ViewBuilder
    func ImageView(photo: PexelPhoto) -> some View {
        VStack(spacing: 0) {
            CachedAsyncImage(
                url: photo.originalImage,
                placeholder: {
                    ProgressView()
                },
                image: {data in
                    Image(cpImage: data)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .frame(
                            maxWidth: CGFloat( photo.width),
                            maxHeight: CGFloat( photo.height))
                        
                },
                error: { error in
                    MessageView(message: error)
                }
            )
            .matchedGeometryEffect(id: "\(photo.id)", in: namespace)
            .padding()
            .onTapGesture { onClose() }
        }
    }
    
    
    private func onClose() {
        withAnimation { showed = false }
    }
    
    func labelOfError() -> String {
        
        if !model.hasError { return "" }
        
        switch model.error {
        case .unauthorized:
            return "unauthorized".toTranslate
        case .notfound:
            return "notfound".toTranslate
        case .unknown:
            return "failure".toTranslate
        }
    }
}

#Preview {
    @Namespace var namespace
    return GetPhotoView(id: 2014422,namespace: namespace, showed: .constant(true))
}
