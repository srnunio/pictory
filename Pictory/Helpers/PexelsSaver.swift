//
//  PhotoLibraryUtils.swift
//  Pictory
//
//  Created by Edvaldo Martins on 27/11/2023.
//
 
import UIKit

final class PexelsSaver: NSObject {
    
    private var repository = DownloadRepository()
    
    private var onSuccess: (() -> Void)?
    
    private var onError: ((Error) -> Void)?
    
    func download(url: String,objectId: Int = 0, saveLocally: Bool = false, onSuccess: (() -> Void)?, onError: ((Error) -> Void)?) {
        self.onSuccess = onSuccess
        self.onError = onError
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: url)!)
            DispatchQueue.main.async { [self] in
                if data == nil {
                    onError?( NSError(domain:"", code: 100, userInfo:nil))
                }else{
                    if saveLocally {
                        writeToPhotoLocally(objectId: objectId,image: UIImage(data: data!)!)
                    }else {
                        writeToPhotoAlbum(image: UIImage(data: data!)!)
                    }
                }
            }
        }
    }
    
    private func writeToPhotoLocally(objectId: Int, image: UIImage) {
        let result = repository.save(objectId: objectId, image: image)
        if result {
            onSuccess?()
        }else {
            onError?( NSError(domain:"", code: 100, userInfo:nil))
        }
    }
    
    private func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc private func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            onError?(error)
        }else{
            onSuccess?()
        }
    }
}
