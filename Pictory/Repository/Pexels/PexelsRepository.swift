//
//  PexelsRepository.swift
//  Pictory
//
//  Created by Edvaldo Martins on 25/11/2023.
//

import Foundation

class PexelsRepository: PexelsProtocol {
    func getAll(page: Int, perPage: Int) async throws -> PexelResponse {
        
        print("PexelsRepository::getAll(page(\(page)),perPage(\(perPage))")
        
        let headers = [
            "content-type": "application/json",
            "authorization": Constants.apiKey
        ]
        
        var request = URLRequest(url: URL(string: "\(Constants.api)/?page=\(page)&per_page=\(perPage)")!)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(PexelResponse.self, from: data)
    }
    
    
}
