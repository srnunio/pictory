//
//  PexelsRepository.swift
//  Pictory
//
//  Created by Edvaldo Martins on 25/11/2023.
//

import Foundation

class PexelsRepository: PexelsProtocol {
    
    func getId(id: Int) async throws -> PexelPhoto? {
        do {
            let headers = [
                "content-type": "application/json",
                "authorization": Constants.apiKey,
            ]
            
            var request = URLRequest(url: URL(string: "\(Constants.api)/photos/\(id)")!)
            
            request.httpMethod = "GET"
            
            request.allHTTPHeaderFields = headers
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            
            return try decoder.decode(PexelPhoto.self, from: data)
            
        }catch {
            return nil
        }
    }
    
    func getAll(page: Int, perPage: Int) async throws -> PexelResponse {
        
        print("PexelsRepository::getAll(page(\(page)),perPage(\(perPage))")
        
        let headers = [
            "content-type": "application/json",
            "authorization": Constants.apiKey
        ]
        
        var request = URLRequest(url: URL(string: "\(Constants.api)/v1/curated/?page=\(page)&per_page=\(perPage)")!)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = headers
        
        let (data, error) = try await URLSession.shared.data(for: request)
        
        print("getAll \(error)")
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(PexelResponse.self, from: data)
        
    }
    
    
}
