//
//  WebServices.swift
//  Mobius Coding test
//
//  Created by Adaps on 09/12/20.
//  Copyright © 2020 Task. All rights reserved.
//

import Foundation
struct APIService {
    
    let baseURL = URL(string: "https://run.mocky.io/v3/")!
    static let shared = APIService()
    let decoder = JSONDecoder()
    
    enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
        case internetError(error: Error)
       }
    
    enum Endpoint {
        case getBonusCouponList
        func path() -> String {
            switch self {
            case .getBonusCouponList:
                return "4c663239-03af-49b5-bcb3-0b0c41565bd2"
            }
        }
    }
    
    
    
    /// ---------------------------------
    /// GET Request
    /// ---------------------------------
    
    func GET<T: Codable>(endpoint: Endpoint, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        var request = URLRequest(url: queryURL)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError(error: error!)))
                }
                return
            }
            do {
                let object = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(object))
                }
            } catch let error {
                DispatchQueue.main.async {
                    #if DEBUG
                    print("JSON Decoding Error: \(error)")
                    #endif
                    completionHandler(.failure(.jsonDecodingError(error: error)))
                }
            }
        }
        task.resume()
    }
    
}
