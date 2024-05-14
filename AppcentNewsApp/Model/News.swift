//
//  Model.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 8.05.2024.
//

import Foundation

// MARK: - ResponseResult
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    let code : String?
    let message : String?
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
