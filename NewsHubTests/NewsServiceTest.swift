//
//  NewsServiceTest.swift
//  NewsHubTests
//
//  Created by Runa Alam on 19/7/2023.
//

import XCTest
@testable import NewsHub

class NewsServiceTests: XCTestCase {
    var apiClient: MockAPIClient!
    var newsService: NewsService!
    
    override func setUp() {
        super.setUp()
        
        apiClient = MockAPIClient(shouldSucceed: true)
        newsService = NewsService(apiClient: apiClient)
    }
    
    override func tearDown() {
        apiClient = nil
        newsService = nil
        super.tearDown()
    }
    
    func testFetchAllNews_WithSuccessResponse_ReturnsNewsStories() {
        // Arrange
        let response = NewsResponseModel(
            id: 1,
            assetType: "ASSET_LIST",
            url: "https://example.com",
            lastModified: 123456789,
            timeStamp: 123456789,
            onTime: 123456789,
            displayName: "News",
            assets: []
        )
        let expectedResult = NewsStories(
            id: 1,
            assetType: .assetList,
            url: "https://example.com",
            lastModified: 123456789,
            timeStamp: 123456789,
            displayName: "News",
            onTime: 123456789,
            news: []
        )

        let encoder = JSONEncoder()
        guard let responseData = try? encoder.encode(response) else {
            XCTFail("Failed to encode response")
            return
        }

        apiClient.responseData = responseData

        let expectation = self.expectation(description: "Completion called")
        var result: Result<NewsStories, APIError>?

        // Act
        newsService.fetchAllNews { completion in
            result = completion
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)

        // Assert
        switch result {
        case .success(let newsStories):
            XCTAssertEqual(newsStories, expectedResult)
        case .failure(let error):
            XCTFail("Expected success result, but received error: \(error)")
        case .none:
            XCTFail("Expected result, but received nil")
        }
    }

    func testFetchAllNews_WithFailureResponse_ReturnsError() {
        // Arrange
        let expectedError = APIError.requestFailed

        apiClient.responseError = expectedError

        let expectation = self.expectation(description: "Completion called")
        var result: Result<NewsStories, APIError>?

        // Act
        newsService.fetchAllNews { completion in
            result = completion
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)

        // Assert
        switch result {
        case .success(_):
            XCTFail("Expected failure result, but received success")
        case .failure(let error):
            XCTAssertEqual(error, expectedError)
        case .none:
            XCTFail("Expected result, but received nil")
        }
    }
}

class MockAPIClient: APIClient {
    var shouldSucceed: Bool
    var responseData: Data?
    var responseError: APIError?
    
    init(shouldSucceed: Bool, responseData: Data? = nil, responseError: APIError? = nil) {
        self.shouldSucceed = shouldSucceed
        self.responseData = responseData
        self.responseError = responseError
    }
    
    func fetchData<T>(from endpoint: String, responseType: T.Type, completion: @escaping (Result<T, NewsHub.APIError>) -> Void) where T : Decodable {
        if shouldSucceed {
            if let responseData = responseData {
                do {
                    let decodedResponse = try JSONDecoder().decode(responseType, from: responseData)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(APIError.decodingFailed))
                }
            } else {
                completion(.failure(APIError.requestFailed))
            }
        } else {
            if responseError != nil {
                completion(.failure(APIError.responseError))
            } else {
                completion(.failure(APIError.requestFailed))
            }
        }
    }
}

