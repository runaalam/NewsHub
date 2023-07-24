//
//  NewsResponseModelTest.swift
//  NewsHubTests
//
//  Created by Runa Alam on 18/7/2023.
//

import XCTest
@testable import NewsHub

/// NewsResponseModelTests is a test class containing test cases for decoding the NewsResponseModel from JSON data.
class NewsResponseModelTests: XCTestCase {
    
    /// Test the decoding of the NewsResponseModel from JSON data.
    func testNewsResponseDecoding() throws {
        // Get the JSON string representation of the NewsResponseModel.
        let jsonString = getJsonString()
        
        // Convert the JSON string to data.
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert JSON string to data")
            return
        }
        
        do {
            // Decode the JSON data into a NewsResponseModel object.
            let response = try JSONDecoder().decode(NewsResponseModel.self, from: jsonData)
            
            // Assert that the properties of the NewsResponseModel object are correctly decoded.
            XCTAssertEqual(response.id, 123)
            XCTAssertEqual(response.assetType, "ASSET_LIST")
            XCTAssertEqual(response.url, "https://example.com/newsStories")
            XCTAssertEqual(response.lastModified, 1629288400)
            XCTAssertEqual(response.timeStamp, 1629288400)
            XCTAssertEqual(response.onTime, 1629288400)
            XCTAssertEqual(response.displayName, "AFR iPad Editor's Choice")
            XCTAssertEqual(response.assets.count, 1)
            
            // Compare the properties of the first asset in the NewsResponseModel.

            let asset = response.assets.first
            XCTAssertEqual(asset?.id, 456)
            XCTAssertEqual(asset?.assetType, "ARTICLE")
            XCTAssertEqual(asset?.url, "https://example.com/news1")
            XCTAssertEqual(asset?.lastModified, 1629288400)
            XCTAssertEqual(asset?.timeStamp, 1629288400)
            XCTAssertEqual(asset?.authors.count, 0)
            XCTAssertEqual(asset?.headline, "Article Headline")
            XCTAssertEqual(asset?.byLine, "Runa Alam")
            XCTAssertEqual(asset?.theAbstract, "Article Abstract")
            XCTAssertEqual(asset?.body, "Article Body")
            XCTAssertEqual(asset?.extendedAbstract, "Extended Article Abstract")
            XCTAssertEqual(asset?.numberOfComments, 10)
            XCTAssertEqual(asset?.acceptComments, true)
            XCTAssertEqual(asset?.companies.count, 0)
            XCTAssertEqual(asset?.categories.count, 0)
            XCTAssertEqual(asset?.relatedImages.count, 1)
            
            // Compare the properties of the first related image in the asset.
            let relatedImage = asset?.relatedImages.first
            XCTAssertEqual(relatedImage?.id, 789)
            XCTAssertEqual(relatedImage?.assetType, "IMAGE")
            XCTAssertEqual(relatedImage?.url, "https://example.com/related_image.jpg")
            XCTAssertEqual(relatedImage?.authors.count, 0)
            XCTAssertEqual(relatedImage?.lastModified, 1629288400)
            XCTAssertEqual(relatedImage?.sponsored, false)
            XCTAssertEqual(relatedImage?.timeStamp, 1629288400)
            XCTAssertEqual(relatedImage?.description, "Related Image")
            XCTAssertEqual(relatedImage?.type, "thumbnail")
            XCTAssertEqual(relatedImage?.height, 100)
            XCTAssertEqual(relatedImage?.width, 100)
            XCTAssertEqual(relatedImage?.photographer, "Runa Alam")
            
        } catch {
            XCTFail("Failed to decode JSON: \(error)")
        }
    }
    
    /// Get the JSON string representation of the NewsResponseModel for testing purposes.
    func getJsonString() -> String {
        let jsonString = """
        {
            "id": 123,
            "assetType": "ASSET_LIST",
            "url": "https://example.com/newsStories",
            "lastModified": 1629288400,
            "timeStamp": 1629288400,
            "onTime": 1629288400,
            "displayName": "AFR iPad Editor's Choice",
            "assets": [
                {
                    "id": 456,
                    "assetType": "ARTICLE",
                    "url": "https://example.com/news1",
                    "lastModified": 1629288400,
                    "timeStamp": 1629288400,
                    "authors": [],
                    "headline": "Article Headline",
                    "byLine": "Runa Alam",
                    "theAbstract": "Article Abstract",
                    "body": "Article Body",
                    "extendedAbstract": "Extended Article Abstract",
                    "numberOfComments": 10,
                    "acceptComments": true,
                    "companies": [],
                    "categories": [],
                    "relatedImages": [
                        {
                            "id": 789,
                            "assetType": "IMAGE",
                            "url": "https://example.com/related_image.jpg",
                            "authors": [],
                            "lastModified": 1629288400,
                            "sponsored": false,
                            "timeStamp": 1629288400,
                            "description": "Related Image",
                            "type": "thumbnail",
                            "height": 100,
                            "width": 100,
                            "photographer": "Runa Alam",
                            "xLarge2x": null,
                            "xLarge": null,
                            "large2x": null,
                            "large": null,
                            "thumbnail2x": null,
                            "thumbnail": null
                        }
                    ]
                }
            ]
        }
        """
        return jsonString
    }
}

