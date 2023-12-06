//
//  PhotosViewModel.swift
//  Pictory
//
//  Created by Edvaldo Martins on 25/11/2023.
//

import SwiftUI

@MainActor
class PhotosViewModel: ObservableObject {
    fileprivate var repository: PexelsProtocol = PexelsRepository()
    @Published fileprivate var response: PexelResponse = PexelResponse.empty
    @Published fileprivate var _currentPage: Int = 1 
    @Published fileprivate var _isBusy: Bool = false
    @Published fileprivate var photos: [PexelPhoto] = [PexelPhoto]()
    @Published fileprivate var _error: PexelsError?
    
    var isBusy: Bool {
        get { _isBusy }
    } 
    
    var hasNext: Bool {
        get { response.hasNext }
    } 
    
    var hasPrevious: Bool {
        get { response.hasNext }
    }
    
    var hasNotData: Bool {
        get { !response.hasData }
    }
    
    var hasData: Bool {
        get { response.hasData }
    }
    
    var list: [PexelPhoto] {
        get { photos }
    }
    
    var currentPage: Int {
        get { _currentPage }
    }
    
    var totalPage: Int {
        get { response.totalPage }
    }
    
    var hasError: Bool {
        get { _error != nil }
    }
    
    var error: PexelsError {
        get { _error! }
    }
    
    fileprivate func setData(_ result: PexelResponse, _ refresh: Bool) {
        if result.hasData {
            if refresh {
                photos = result.data as! [PexelPhoto]
            }else{
                result.data.forEach { item in
                    photos.append(item as! PexelPhoto)
                }
            }
        }else {
            _error = .notfound
        }
        self.response = result
    }
    
    func load (refresh: Bool = false) {
        if _isBusy { return }
        repository.getAll(page: _currentPage, perPage: Constants.perPage) { response in
            
            self._isBusy = false
            
            switch response {
                case .success(let result):
                    self.setData(result, refresh)
                case .failure(let error):
                    self._error = error
                }
        }
        
//        Task {
//           
//            photos = []
//            
//            if refresh { _currentPage = 1}
//            
//            self._isBusy = true
//            
//            let result = try await repository.getAll(page: _currentPage, perPage: Constants.perPage)
//            
//            self._isBusy = false
//            
//            if result.hasData {
//                if refresh {
//                    photos = result.data as! [PexelPhoto]
//                }else{
//                    result.data.forEach { item in
//                        photos.append(item as! PexelPhoto)
//                    }
//                } 
//            }
//            response = result
//        }
    }
    
    func onPrevious() {
        if _currentPage == 1 { return }
        _currentPage -= 1
        load()
    }
    
    func onNext() {
        if !response.hasNext { return }
        _currentPage += 1
        load()
    }
    
    func getPosition(photo: PexelPhoto) -> Int {
        return photos.firstIndex {item in
            return item.id == photo.id
        } ?? -1
    }
    
    func isLastItem(_ photo: PexelPhoto) -> Bool {
        let index = getPosition(photo: photo)
        return index == photos.count - 1
    }
    
    func updateFavoriteValue(_ photo: PexelPhoto, _ value: Bool) {
        Task {
            let index = getPosition(photo: photo)
            if index < 0 { return }
            self.photos[index].isFavorite = value
        }
    }
    
}
