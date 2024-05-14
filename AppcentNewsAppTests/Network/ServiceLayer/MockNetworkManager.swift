//
//  MockNetworkManager.swift
//  AppcentNewsAppTests
//
//  Created by Burak Gül on 14.05.2024.
//

import Foundation
import Alamofire

@testable import AppcentNewsApp
class MockNetworkManager: NetworkManaging {
    
    
    func request<T:Codable>(_ requestString: String, decodeToType type: T.Type, completion: @escaping (Result<T, Error>) -> ()){
        
        
    }
    
    
}
