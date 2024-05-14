//
//  APIURL.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 10.05.2024.
//

import Foundation

enum NewsAPIURL : String {
    case baseURL = "https://newsapi.org/"
    case path = "v2/everything"
    case searchQuery = "?q="
    case pageParameter = "&page="
    case pageSizeParameter = "&pageSize="
    case apiKeyParameter = "&apiKey="
    case apiKeyValue = "51ee81f1d80f44fba88597a4aa12bae3"

    
}
