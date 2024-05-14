//
//  NewsService.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 10.05.2024.
//

import Foundation

class NewsService {
    //MARK: - Private Variables
    private let networkManager : NetworkManaging
    
    //MARK: - Dependency Injection
    init(networkManaging: NetworkManaging) {
        self.networkManager = networkManaging
    }
    
    func getNews(searchWord: String, page: Int,pageSize : Int, completion: @escaping (Result<NewsResponse,Error>) -> ()) {
        let baseURL = NewsAPIURL.baseURL.rawValue
        let path = NewsAPIURL.path.rawValue
        let searchQuery = NewsAPIURL.searchQuery.rawValue
        let pageParameter = NewsAPIURL.pageParameter.rawValue
        let pageSizeParameter = NewsAPIURL.pageSizeParameter.rawValue
        let apiKeyParameter = NewsAPIURL.apiKeyParameter.rawValue
        let apiKeyValue = NewsAPIURL.apiKeyValue.rawValue
        let url = baseURL + path + searchQuery + "\(searchWord)" + pageParameter + "\(page)" + pageSizeParameter + "\(pageSize)" + apiKeyParameter + apiKeyValue
        
        DispatchQueue.global().async {
            self.networkManager.request(url, decodeToType: NewsResponse.self) { result in
                
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
        
        
        
        
        
        
    }
    
}






