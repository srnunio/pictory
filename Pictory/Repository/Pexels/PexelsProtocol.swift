//
//  ApiProtocol.swift
//  Pictory
//
//  Created by Edvaldo Martins on 25/11/2023.
//

import Foundation

enum PexelsError: String, Error {
    case unauthorized
    case notfound
    case unknown
}

protocol PexelsProtocol {
    // MARK: Search for a matching photo [id]
    func getId(id: Int, completion: @escaping (Result<PexelPhoto,PexelsError>) -> Void )
    // MARK: browse all photos
    func getAll(page: Int, perPage: Int, completion: @escaping (Result<PexelResponse,PexelsError>) -> Void )
}
