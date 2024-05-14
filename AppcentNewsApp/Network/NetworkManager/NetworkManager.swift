//
//  NetworkManager.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 10.05.2024.
//

import Foundation
import Alamofire

//MARK: - Protocol
protocol NetworkManaging {
    func request<T: Codable>(_ requestString: String,
                             decodeToType type: T.Type,
                             completion: @escaping (Result<T,Error>) -> ())
}

//MARK: - Class

class NetworkManager : NetworkManaging   {
    
    func request<T: Codable>(_ requestString: String,
                             decodeToType type: T.Type,
                             completion: @escaping (Result<T,Error>) -> ()) {
        AF.request(requestString, method: .get).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(type.self, from: data)
                    
                    completion(.success(result))
                } catch {
                    
                    completion(.failure(error))
                }
            case .failure(let error):
                
                completion(.failure(error))
            }
        }
    }
    
    
}

