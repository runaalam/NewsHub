//
//  NewsAPIClientTest.swift
//  NewsHubTests
//
//  Created by Runa Alam on 18/7/2023.
//

import XCTest
@testable import NewsHub

class NewsAPIClientTests: XCTestCase {
    var client: NewsAPIClient!

    override func setUp() {
        super.setUp()
        client = NewsAPIClient()
    }

    override func tearDown() {
        client = nil
        super.tearDown()
    }

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
    
    func testFetchData_WithValidURL_ReturnsSuccessResult() {
       
        // Given response type
        struct PostResponse: Codable {
            let userId: Int
            let id: Int
            let title: String
            let body: String
        }

        // Given Url
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
    
    func decodeData<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let decodedResponse = try decoder.decode(T.self, from: data)
        return decodedResponse
    }

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

        wait(for: [expectation], timeout: 5.0)
    }
    
    // Mock response structure for testing
    struct MockResponse: Codable {
        let data: Data
    }
}



