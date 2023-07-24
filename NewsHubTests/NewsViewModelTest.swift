//
//  NewsViewModelTest.swift
//  NewsHubTests
//
//  Created by Runa Alam on 19/7/2023.
//

import XCTest
@testable import NewsHub

/// NewsViewModelTests is a test class containing test cases for the NewsViewModel class.
class NewsViewModelTests: XCTestCase {

    /// Test the fetchAllNews method with a successful API response.
    func testFetchAllNews_WithSuccessResponse_SetsNewsStories() {
        // Arrange
        let viewModel = NewsViewModel()
        
        // Create mock news stories data
        let mockNewsStories = MockData.makeNewsStories(id: 1, url: "https://example.com/news-stories", newsList: [])
        let mockResponse = Result<NewsStories, APIError>.success(mockNewsStories)
        
        // Create a mock NewsService with a success response
        let mockNewsService = MockNewsService(result: mockResponse)
        viewModel.newsService = mockNewsService
        
        // Create an expectation to wait for the asynchronous call to complete
        let expectation = self.expectation(description: "Wait for fetching news")
        
        // Act
        viewModel.fetchAllNews()
        
        // Assert
        XCTAssertTrue(viewModel.isLoading) // Verify that isLoading is set to true before fetching news
        XCTAssertNil(viewModel.errorText) // Verify that errorText is nil before fetching news
        
        // Simulate asynchronous behaviour
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(viewModel.isLoading) // Verify that isLoading is set to false after fetching news
            XCTAssertNil(viewModel.errorText) // Verify that errorText is nil after fetching news
            XCTAssertNotNil(viewModel.newsStories) // Verify that newsStories is set with the expected data
            XCTAssertEqual(viewModel.newsStories?.id, mockNewsStories.id)
            XCTAssertEqual(viewModel.newsStories?.url, mockNewsStories.url)
            XCTAssertEqual(viewModel.newsStories?.news, mockNewsStories.news)
            XCTAssertEqual(viewModel.newsStories?.assetType, mockNewsStories.assetType)
            XCTAssertEqual(viewModel.newsStories?.displayName, mockNewsStories.displayName)
            XCTAssertEqual(viewModel.newsStories?.lastModified, mockNewsStories.lastModified)
            
            // Fulfil the expectation to mark the async block as completed
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchAllNews_WithFailureResponse_SetsErrorText() {
        // Arrange
        let mockError = APIError.responseError // Choose an appropriate error for testing
        let mockService = MockNewsService(result: .failure(mockError))
        let viewModel = NewsViewModel()
        viewModel.newsService = mockService
               
        // Act
        viewModel.fetchAllNews()
        
        // Simulate asynchronous behaviour
        let expectation = self.expectation(description: "Wait for news fetch completion")
        DispatchQueue.main.async {
            // Verify that isLoading is set to false after fetching news fail
            XCTAssertFalse(viewModel.isLoading)
            // Verify that errorText is set to the expected value
            XCTAssertEqual(viewModel.errorText, "Something wrong try again!")
            // Verify that newsStories is still nil after a failure response
            XCTAssertNil(viewModel.newsStories)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}

// MockNewsService to replace the actual NewsService during testing
class MockNewsService: NewsService {
    let result: Result<NewsStories, APIError>
    
    init(result: Result<NewsStories, APIError>) {
        self.result = result
        super.init(apiClient: MockAPIClient(shouldSucceed: true)) // Call the designated initializer of NewsService
    }
    
    override func fetchAllNews(completion: @escaping CompletionHandler) {
        completion(result)
    }
}
