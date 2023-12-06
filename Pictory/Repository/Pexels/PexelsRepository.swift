//
//  PexelsRepository.swift
//  Pictory
//
//  Created by Edvaldo Martins on 25/11/2023.
//

import Foundation

class PexelsRepository: PexelsProtocol {
    func getAll(page: Int, perPage: Int, completion: @escaping (Result<PexelResponse, PexelsError>) -> Void) {
        let headers = [
            "content-type": "application/json",
            "authorization": Constants.apiKey
        ]
        
        var request = URLRequest(url: URL(string: "\(Constants.api)/v1/curated/?page=\(page)&per_page=\(perPage)")!)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            do {
                guard let data else {
                    completion(.failure(.notfound))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,  401 != response.statusCode else {
                    completion(.failure(.unauthorized))
                    return
                }
                
                guard 404 != response.statusCode else {
                    completion(.failure(.notfound))
                    return
                }
                
                let decoder = JSONDecoder()
                
                completion(.success(try decoder.decode(PexelResponse.self, from: data)))
            }catch {
                completion(.failure(.unknown))
            }
        }.resume()
        
    }
    
    func getId(id: Int, completion: @escaping (Result<PexelPhoto, PexelsError>) -> Void) {
        
        let headers = [
            "content-type": "application/json",
            "authorization": Constants.apiKey,
        ]
        
        var request = URLRequest(url: URL(string: "\(Constants.api)/v1/photos/\(id)")!)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            do {
                guard let data else {
                    completion(.failure(.notfound))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,  401 != response.statusCode else {
                    completion(.failure(.unauthorized))
                    return
                }
                
                guard 404 != response.statusCode else {
                    completion(.failure(.notfound))
                    return
                }
                
                let decoder = JSONDecoder()
                
                completion(.success(try decoder.decode(PexelPhoto.self, from: data)))
            }catch {
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
