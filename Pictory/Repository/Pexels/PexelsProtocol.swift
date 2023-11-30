//
//  ApiProtocol.swift
//  Pictory
//
//  Created by Edvaldo Martins on 25/11/2023.
//

import Foundation

protocol PexelsProtocol {
    func getAll(page: Int, perPage: Int) async throws -> PexelResponse
}
