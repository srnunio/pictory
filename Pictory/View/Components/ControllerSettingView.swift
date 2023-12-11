//
//  ControllerSettingView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 26/11/2023.
//

import SwiftUI

struct ControllerSettingView: View {
    @Binding var isBusy: Bool
    @Binding var columns: Double
    @Binding var currentPage: Int
    @Binding var totalPage: Int
    @State private var showSlider: Bool = false
    
    var onNext: (() -> Void)?
    
    var onPrevious: (() -> Void)?
    
    @ViewBuilder
    func ButtonView(systemName: String, onTap: (() -> Void)?) -> some View{
        let enabled = onTap != nil
        Button { 
            if enabled { onTap?() }
        }
        label: {
            Image(systemName: systemName)
                .foregroundColor(enabled ? .primary : .secondary)
                .padding(.all, 10)
                .background(Circle().fill(.ultraThinMaterial))
                
        }
    }
    
    var body: some View {
        VStack {
            if showSlider {
                sliderView
            }else {
                defautlControllerView
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 12)
        .background(.ultraThinMaterial)
    }
    
    var sliderView: some View {
        HStack {
            Button {
                withAnimation {
                    showSlider = false
                }
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.primary)
                    .padding(.all, 10)
                    .background(Circle().fill(.ultraThinMaterial))
            }
            .rotationEffect(.init(degrees: 45))
            Spacer()
            Slider(
                value: $columns,
                in: 1...4
            )
            Spacer()
        }
    }
    
    var defautlControllerView: some View {
        HStack {
            Button {
                if  !isBusy {
                    withAnimation {
                        showSlider = true
                    }
                }
            } label: {
                Image(systemName: "square.grid.3x3")
                    .foregroundColor( isBusy ? .secondary : .primary)
                    .padding(.all, 10)
                    .background(Circle().fill(.ultraThinMaterial))
            }
            Spacer()
            ButtonView(systemName: "arrow.left",onTap: isBusy ? nil : onPrevious)
            Text("\(currentPage)/\(totalPage)")
                .font(.title3)
                .fontWeight(.regular)
                .foregroundColor(isBusy ? .secondary : .primary)
            ButtonView(systemName: "arrow.forward", onTap: isBusy ? nil :  onNext)
        }
    }
}

#Preview {
    return ControllerSettingView(
        isBusy: .constant(true),
        columns: .constant(2),
        currentPage: .constant(2),
        totalPage: .constant(10),
        onNext: {}, onPrevious: {})
}
