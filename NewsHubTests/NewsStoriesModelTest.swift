//
//  NewsStoriesModelTest.swift
//  NewsHubTests
//
//  Created by Runa Alam on 18/7/2023.
//

import XCTest
@testable import NewsHub

/// NewsStoriesModelTest is a test class containing test cases for the models in the NewsStories application.
class NewsStoriesModelTest: XCTestCase {
    
    // MARK: - NewsStories Tests
    
    /// Test the initialisation of the NewsStories model.
    func testNewsStoriesInitialization() {
        // Create mock News objects.
        let news1 = MockData.makeNews(id: 1, newsImage: MockData.makeNewsImage(id: 1))
        let news2 = MockData.makeNews(id: 2, newsUrl: "https://example.com/news2", newsImage: MockData.makeNewsImage(id: 2))
       
        // Create the NewsStories object using the mock News objects.
        let newsStories = MockData.makeNewsStories(id: 1, url: "https://example.com/news-stories", newsList: [news1, news2])
        
        // Assert that the properties of the NewsStories object are correctly initialized.
        XCTAssertEqual(newsStories.id, 1)
        XCTAssertEqual(newsStories.url, "https://example.com/news-stories")
        XCTAssertEqual(newsStories.news[0], news1)
        XCTAssertEqual(newsStories.news[1], news2)
    }
    
    // MARK: - News Tests

    /// Test the initialisation of the News model.
    func testNewsInitialization() {
        // Create a mock NewsImage object.
        let newsImage = MockData.makeNewsImage(id: 1)
        
        // Create the News object using the mock NewsImage.
        let news = News(newsId: 1,
                        newsAssetType: .article,
                        newsUrl: "https://example.com/news",
                        newsLastModified: 123456,
                        newsTimeStamp: 1689656194,
                        headLine: "News Headline",
                        abstract: "News Abstract",
                        extendedAbstract: "Extended Abstract",
                        byLine: "Author",
                        newsImage: newsImage,
                        newsBody: "News Body")

        // Assert that the properties of the News object are correctly initialized.
        XCTAssertEqual(news.newsId, 1)
        XCTAssertEqual(news.newsAssetType, .article)
        XCTAssertEqual(news.newsUrl, "https://example.com/news")
        XCTAssertEqual(news.newsLastModified, 123456)
        XCTAssertEqual(news.newsTimeStamp, 1689656194)
        XCTAssertEqual(news.headLine, "News Headline")
        XCTAssertEqual(news.abstract, "News Abstract")
        XCTAssertEqual(news.extendedAbstract, "Extended Abstract")
        XCTAssertEqual(news.byLine, "Author")
        XCTAssertEqual(news.newsImage, newsImage)
        XCTAssertEqual(news.newsBody, "News Body")
    }
    
    // MARK: - NewsImage Tests
    
    /// Test the initialisation of the NewsImage model.
    func testNewsImageInitialization() {
        let newsImage = NewsImage(id: 1,
                                  assetType: .image,
                                  imageUrl: "https://example.com/image.jpg",
                                  type: "thumbnail",
                                  description: "Image Description",
                                  lastModified: 1234567,
                                  photographer: "Runa Alam",
                                  timeStamp: 1630345678,
                                  height: 0,
                                  width: 300)

        XCTAssertEqual(newsImage.id, 1)
        XCTAssertEqual(newsImage.assetType, .image)
        XCTAssertEqual(newsImage.imageUrl, "https://example.com/image.jpg")
        XCTAssertEqual(newsImage.type, "thumbnail")
        XCTAssertEqual(newsImage.description, "Image Description")
        XCTAssertEqual(newsImage.lastModified, 1234567)
        XCTAssertEqual(newsImage.photographer, "Runa Alam")
        XCTAssertEqual(newsImage.timeStamp, 1630345678)
        XCTAssertEqual(newsImage.height, 0)
        XCTAssertEqual(newsImage.width, 300)
    }
}
