//
//  ImageCacheTest.swift
//  NewsHubTests
//
//  Created by Runa Alam on 23/7/2023.
//

import SwiftUI
import XCTest
@testable import NewsHub

/// ImageCacheTests is a test class containing a test case for the ImageCache class.
class ImageCacheTests: XCTestCase {
    func testImageCache() {
        // Arrange
        let cache = ImageCache()
        
        // Create a test image
        let testImage = Image(systemName: "photo")
            
        // Cache the test image
        let testKey = "testImage"
        cache.setImage(testImage, forKey: testKey)
        
        // Retrieve the cached image using the test key
        let cachedImage = cache.getImage(forKey: testKey)
        
        // Assert
        // Ensure that the cached image is not nil, indicating that it was saved in the cache successfully.
        XCTAssertNotNil(cachedImage)
    }
}
