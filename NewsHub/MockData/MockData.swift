//
//  MockData.swift
//  NewsHub
//
//  Created by Runa Alam on 18/7/2023.
//

import Foundation

public struct MockData {
 
    static func makeNewsStories(id: Int, url: String = "https://example.com/news-stories", newsList: [News] = []) -> NewsStories {
        return NewsStories(id: id,
                           assetType: .assetList,
                           url: url,
                           lastModified: 1689656194,
                           timeStamp: 1689656194,
                           displayName: "AFR iPad Editor's Choice",
                           onTime: 1689656194,
                           news: newsList)
    }
    
    static func makeNews(id: Int, newsUrl: String = "https://example.com/news", newsImage: NewsImage) -> News {
        return News(newsId: id,
                    newsAssetType: .article,
                    newsUrl: newsUrl,
                    newsLastModified: 1689656194,
                    newsTimeStamp: 1689656194,
                    headLine: "This is a headline",
                    abstract: "This is abstract",
                    extendedAbstract: "This is extended abstract",
                    byLine: "This is byLine",
                    newsImage: newsImage,
                    newsBody: "This is news body")
    }
    
    static func makeNewsImage(id: Int) -> NewsImage {
        return NewsImage(id: id,
                assetType: .image,
                imageUrl: "https://www.exampleImageURl.com",
                type: "landscape",
                description: "This is a image description",
                lastModified: 1689656194,
                photographer: "Runa Alam",
                timeStamp: 1689656194,
                height: 0,
                width: 375)
    }
    
    static func getAssetListJsonString() -> String {
        let jsonString = """
        {
            "id": 123,
            "assetType": "ASSET_LIST",
            "url": "https://example.com/newsStories",
            "lastModified": 1629288400,
            "timeStamp": 1629288400,
            "onTime": 1629288400,
            "displayName": "AFR iPad Editor's Choice",
            "assets": []
        }
        """
        return jsonString
    }
    
    static func getJsonString() -> String {
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
