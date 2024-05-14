//
//  FavoritesManagerTest.swift
//  AppcentNewsAppTests
//
//  Created by Burak Gül on 14.05.2024.
//

import XCTest
@testable import AppcentNewsApp

final class FavoritesManagerTests: XCTestCase {
    
    private var sut: FavoritesManaging!
    private var mockDefaults: UserDefaults!
    private var testArticle1: Article!
    private var testArticle2: Article!

    override func setUp() {
        super.setUp()
        mockDefaults = UserDefaults(suiteName: "testDefaults")
        sut = FavoritesManager(defaults: mockDefaults)
        
        testArticle1 = Article(source: Source(id: "SourceID", name: "SourceName"), author: "AuthorBurakGül", title: "Title", description: "Description", url: "URL", urlToImage: "URLtoImage", publishedAt: "Published", content: "Content")
        testArticle2 = Article(source: Source(id: "SourceID", name: "SourceName"), author: "AuthorBurakGül2", title: "Title2", description: "Description2", url: "URL2", urlToImage: "URLtoImage2", publishedAt: "Published2", content: "Content2")
    }

    override func tearDown() {
        mockDefaults.removePersistentDomain(forName: "testDefaults")
        mockDefaults = nil
        sut = nil
        testArticle1 = nil
        testArticle2 = nil
        super.tearDown()
    }
    
    func test_addFavorite_addsArticleToFavorites() {
        sut.addFavorite(article: testArticle1)
        XCTAssertEqual(sut.getFavorites()[0].url, testArticle1.url)
    }
    
    func test_removeFavorite_removesArticleFromFavorites() {
        sut.addFavorite(article: testArticle1)
        sut.addFavorite(article: testArticle2)
        sut.removeFavorite(article: testArticle1)
        XCTAssertEqual(sut.getFavorites().count, 1)
        XCTAssertEqual(sut.getFavorites()[0].url, testArticle2.url)
    }
    
    func test_getFavorites_returnsAllFavoriteArticles() {
        sut.addFavorite(article: testArticle1)
        sut.addFavorite(article: testArticle2)
        XCTAssertEqual(sut.getFavorites().count, 2)
    }
    
    func test_isItFavorites_returnsTrueIfArticleIsFavorite() {
        sut.addFavorite(article: testArticle1)
        XCTAssertTrue(sut.isItFavorites(article: testArticle1))
    }
    
    func test_isItFavorites_returnsFalseIfArticleIsNotFavorite() {
        XCTAssertFalse(sut.isItFavorites(article: testArticle1))
    }
}

