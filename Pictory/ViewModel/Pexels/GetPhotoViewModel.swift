//
//  GetPhotoViewModel.swift
//  Pictory
//
//  Created by Edvaldo Martins on 06/12/2023.
//

import SwiftUI

@MainActor
class GetPhotoViewModel: ObservableObject {
    fileprivate var repository: PexelsProtocol = PexelsRepository()
    @Published fileprivate var _photo: PexelPhoto?
    @Published fileprivate var _isBusy: Bool = false
    @Published fileprivate var _error: PexelsError?
    
    var isBusy: Bool {
        get { _isBusy }
    }
    
    var hasData: Bool {
        get { _photo != nil }
    }
    
    var hasError: Bool {
        get { _error != nil }
    }
    
    var error: PexelsError {
        get { _error! }
    }
    
    var photo: PexelPhoto {
        get { _photo! }
    }
    
    fileprivate func setData(_ photo: PexelPhoto?) {
        self._photo = photo
    }
    
    func load(id: Int) {
        if _isBusy { return }
        
        self._isBusy = true
        
        repository.getId(id: id) { response in
            DispatchQueue.main.async {
                self._isBusy = false
                switch response {
                case .success(let photo):
                    self.setData(photo)
                case .failure(let error):
                    self._error = error
                }
            }
        }
    }
}
