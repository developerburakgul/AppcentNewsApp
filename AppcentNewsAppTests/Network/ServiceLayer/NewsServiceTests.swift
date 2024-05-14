//
//  NewsServiceTests.swift
//  AppcentNewsAppTests
//
//  Created by Burak Gül on 14.05.2024.
//

import XCTest
@testable import AppcentNewsApp

final class NewsServiceTests: XCTestCase {
    private var sut : NewsService!
    private var mockNetworkManager : MockNetworkManager!
    
    

    override func setUp()  {
        super.setUp()
        mockNetworkManager = .init()
        sut = .init(networkManaging: mockNetworkManager)
    }

    override func tearDown() {
        mockNetworkManager = nil
        sut = nil
        super.tearDown()
        
    }
    
    
    

}
