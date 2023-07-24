//
//  NewsAPIClientTest.swift
//  NewsHubTests
//
//  Created by Runa Alam on 18/7/2023.
//

import XCTest
@testable import NewsHub

/// NewsAPIClientTests is a test class containing test cases for the NewsAPIClient class.
class NewsAPIClientTests: XCTestCase {
    var client: NewsAPIClient!

    override func setUp() {
        super.setUp()
        // Create an instance of NewsAPIClient for testing.
        client = NewsAPIClient()
    }

    override func tearDown() {
        client = nil
        super.tearDown()
    }

    /// Test the isHTTPResponseValid method with a valid HTTPURLResponse.
    func testIsHTTPResponseValid_WithValidResponse_ReturnsTrue() {
        // Arrange
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // Act
        let isValid = client.isHTTPResponseValid(response)
        
        // Assert
        XCTAssertTrue(isValid)
    }

    /// Test the isHTTPResponseValid method with an invalid URLResponse.
    func testIsHTTPResponseValid_WithInvalidResponse_ReturnsFalse() {
        // Arrange
        let response = URLResponse(
            url: URL(string: "https://example.com")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        
        // Act
        let isValid = client.isHTTPResponseValid(response)
        
        // Assert
        XCTAssertFalse(isValid)
    }
    
    /// Test the fetchData method with a valid URL and valid response type.
    func testFetchData_WithValidURL_ReturnsSuccessResult() {
       
        // Given a response type struct for testing.
        struct PostResponse: Codable {
            let userId: Int
            let id: Int
            let title: String
            let body: String
        }

        // Given a valid URL for testing.
        let urlString = URL(string: "https://jsonplaceholder.typicode.com/posts")?.absoluteString ?? ""
        let responseType = [PostResponse].self
        let expectation = XCTestExpectation(description: "Fetch data completion called")
        
        // Act
        client.fetchData(from: urlString, responseType: responseType) { result in
            // Then
            switch result {
            case .success(let posts):
                XCTAssertNotNil(posts)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Expected success result, but received error")
            }
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }

    /// Test the fetchData method with a valid URL but decoding fails.
    func testFetchData_DecodingFail() {
        // Given Url which will consider as valid url
        let urlString = URL(string: "https://example.com")
        let expectation = XCTestExpectation(description: "Fail at decoding")
        let responseType = MockResponse.self

        // Act
        client.fetchData(from: urlString?.absoluteString ?? "", responseType: responseType) { result in
            // It will fail at decoding so will return failure with APIError.decodingFailed
            switch result {
            case .success(_):
                XCTFail("Expected decode fail, but successfully decoded")
            case .failure(let error):
                XCTAssertEqual(error, APIError.decodingFailed)
                expectation.fulfill()

            }
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
 
    /// Test the fetchData method with an invalid URL.
    func testFetchData_WithInvalidURL() {
        // Given
        let invalidURL = "invalid-url"
        let expectation = XCTestExpectation(description: "Fetch data expectation")
        let responseType = MockResponse.self

        // When
        client.fetchData(from: invalidURL, responseType: responseType) { result in
            // Then
            switch result {
            case .success(_):
                XCTFail("Expected failure result, but received success")
            case .failure(let error):
                print("=== \(error) ===")
                XCTAssertEqual(error, APIError.message("unsupported URL"))
                expectation.fulfill()
               
            }
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    
    /// Helper method for decoding data.
    func decodeData<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let decodedResponse = try decoder.decode(T.self, from: data)
        return decodedResponse
    }
    
    /// Mock response structure for testing
    struct MockResponse: Codable {
        let data: Data
    }
}



