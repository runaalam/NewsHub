//
//  ImageCacheTest.swift
//  NewsHubTests
//
//  Created by Runa Alam on 23/7/2023.
//

import SwiftUI
import XCTest
@testable import NewsHub

class ImageCacheTests: XCTestCase {
    func testImageCache() {
        let cache = ImageCache()
        
        // Create a test image
        let testImage = Image(systemName: "photo")
            
        // Cache the test image
        let testKey = "testImage"
        cache.setImage(testImage, forKey: testKey)
        
        // Retrieve the cached image
        let cachedImage = cache.getImage(forKey: testKey)
        
        // Assert that the cached image is not nil so it save in cache successfully
        XCTAssertNotNil(cachedImage)
    }
}
