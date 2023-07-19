//
//  NewsViewModelTest.swift
//  NewsHubTests
//
//  Created by Runa Alam on 19/7/2023.
//

import XCTest
@testable import NewsHub

class NewsViewModelTests: XCTestCase {
    var newsViewModel: NewsViewModel!
    
    override func setUp() {
        super.setUp()
        newsViewModel = NewsViewModel()
    }
    
    override func tearDown() {
        newsViewModel = nil
        super.tearDown()
    }
    
    func testFetchAllNews_WithSuccessResponse_SetsNewsStories() {
        // Arrange
        let expectation = self.expectation(description: "Completion called")
        var receivedNewsStories: NewsStories?
        
        // Act
        newsViewModel.fetchAllNews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            receivedNewsStories = self.newsViewModel.newsStories
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        // Assert
        XCTAssertNotNil(receivedNewsStories)
    }
    
}
