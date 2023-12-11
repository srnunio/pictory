//
//  HomeView.swift
//  Pictory
//
//  Created by Edvaldo Martins on 26/11/2023.
//

import SwiftUI
import Combine
enum HomeViewEnum: String, CaseIterable {
    case photos,favorites, downloads
}

struct HomeView: View {
    @State var columns: Double = 3.0
    @State var openedDetail: Bool = false
    @State var selection: HomeViewEnum = .photos
    @State var photoSelected: PexelPhoto?
    @State var downloadSelected: PexelDownload?
    @State var favoriteSelected: Favorite?
    @State var showed: Bool = false
    @State var showSetting: Bool = false
    @Namespace var animation: Namespace.ID
    
    var navigationBar: some View {
        HStack {
            Text("app_name".toTranslate)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.primary, .secondary],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            Spacer()
            Button { 
                withAnimation {
                    showSetting = true
                }
            }
            label: {
                Image(systemName: "gearshape")
                    .foregroundColor(.primary)
                    .padding(.all, 10)
                    .background(Circle().fill(.ultraThinMaterial))
            }
        }
    }
    
    var pickerView: some View {
        HStack {
            Picker( "",selection: $selection) {
                ForEach(HomeViewEnum.allCases, id: \.self) { option in
                    Text(option.rawValue.toTranslate)
                        .tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0){
                    if !openedDetail {
                        VStack {
                            navigationBar.padding(.horizontal, 10)
                            pickerView
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .foregroundColor(.primary)
                    }
                    TabView (selection: $selection) {
                        PhotosView(
                            openedDetail: $openedDetail,
                            animation: animation,
                            onTappedReceiver: onTapped)
                        .tag(HomeViewEnum.photos)
                        
                        FavoritesView(onTappedReceiver: onTappedFavorite)
                            .tag(HomeViewEnum.favorites)
                            .padding(.horizontal, 16)
                        
                        LocallyDownloadView( 
                            onTappedReceiver: onTappedDownload)
                            .tag(HomeViewEnum.downloads)
                            .padding(.horizontal, 16)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
            .overlay(content: {
                if photoSelected != nil {
                    PhotoDetailsView(
                        showed: $showed,
                        photo: .constant(photoSelected!),
                        namespace: animation)
                } else if downloadSelected != nil  && showed {
                    GetPhotoView(id: Int(downloadSelected!.objectId) ?? 0, namespace: animation, showed:$showed)
                } else if   favoriteSelected != nil && showed {
                    GetPhotoView(id: Int(favoriteSelected!.objectId) ?? 0, namespace: animation, showed:$showed)
                }
            })
            .onChange(of: showed){ _, value in
                if !value && photoSelected != nil { onTapped(nil) }
                if !value && downloadSelected != nil { onTappedDownload(nil) }
            }
            .sheet(isPresented: $showSetting) {
                SettingsView()
            }
        .ignoresSafeArea(.all,edges: .bottom)
            
        }
    }
    
    func onTapped(_ photo: PexelPhoto?) {
        withAnimation {
            photoSelected = photo
            showed = photo != nil
        }
    }
    
    func onTappedDownload(_ download: PexelDownload?) {
        withAnimation {
            downloadSelected = download
            showed = download != nil
        }
    } 
    
    func onTappedFavorite(_ favorite: Favorite?) {
        withAnimation {
            favoriteSelected = favorite
            showed = favorite != nil
        }
    }
}

#Preview {
    HomeView()
}
