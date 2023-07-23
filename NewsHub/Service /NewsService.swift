//
//  NewsService.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import Foundation
import SwiftUI

/// NewsService is a class responsible for fetching and mapping news data using the provided APIClient.
class NewsService {
    let apiClient: APIClient
    
    /// Initialise the NewsService with the provided APIClient.
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // Define a type alias for the completion handler used in fetchAllNews method.
    typealias CompletionHandler = (Result<NewsStories, APIError>) -> Void
    
    /// Method to fetch all news from the API using the APIClient.
    /// It takes a completion handler that is called with the result of the API call.
    func fetchAllNews(completion: @escaping CompletionHandler) {
        
        // Define the endpoint to fetch news data.
        let endpoint = Endpoint.fetchNews
        
        // Use the APIClient to fetch data from the specified endpoint.
        apiClient.fetchData(from: endpoint.url?.absoluteString ?? "", responseType: NewsResponseModel.self) { result in
            switch result {
            case .success(let response):
                do {
                    let newsStories = try self.mapNewsData(response)
                    completion(.success(newsStories))
                } catch {
                    completion(.failure(APIError.message("Mapping error")))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Method to map the fetched response to NewsStories object.
    /// It takes the NewsResponseModel and returns the mapped NewsStories.
    func mapNewsData(_ response: NewsResponseModel) throws -> NewsStories {
        
        // Extract necessary properties from the response.
        let id = response.id
        let assetType = AssetType(rawValue: response.assetType) ?? .assetList
        let url = response.url
        let lastModified = response.lastModified
        let timeStamp = response.timeStamp
        let displayName = response.displayName
        let onTime = response.onTime
        
        // Create an empty array to store mapped News objects.
        var newsList: [News] = []
        
        // Iterate through the assets in the response and map them to News objects.
        for asset in response.assets {
            // Extract necessary properties from the asset.
            let newsId = asset.id
            let newsAssetType = AssetType(rawValue: asset.assetType) ?? .assetList
            let newsUrl = asset.url
            let newsLastModified = asset.lastModified
            let newsTimeStamp = asset.timeStamp
            let headLine = asset.headline
            let abstract = asset.theAbstract
            let extendedAbstract = asset.extendedAbstract
            let byLine = asset.byLine
            let newsBody = asset.body
            
            // Get the smallest news image from the related images in the asset.
            guard let newsImage: NewsImage = getSmallestNewsImage(images: asset.relatedImages) else {
                fatalError("Fail to get smallest image")
            }
            
            // Create a News object using the extracted properties.
            let newsItem = News(newsId: newsId,
                                newsAssetType: newsAssetType,
                                newsUrl: newsUrl,
                                newsLastModified: newsLastModified,
                                newsTimeStamp: newsTimeStamp,
                                headLine: headLine,
                                abstract: abstract,
                                extendedAbstract: extendedAbstract,
                                byLine: byLine,
                                newsImage: newsImage,
                                newsBody: newsBody)
            
            // Add the mapped News object to the list.
            newsList.append(newsItem)
            
        }
        
        // Sort the news list in descending order based on the newsTimeStamp.
        let sortedNewsList = newsList.sorted(by: { $0.newsTimeStamp > $1.newsTimeStamp })
        
        // Create the NewsStories object using the extracted properties and the sorted news list.
        return NewsStories(id: id,
                           assetType: assetType,
                           url: url,
                           lastModified: lastModified,
                           timeStamp: timeStamp,
                           displayName: displayName,
                           onTime: onTime,
                           news: sortedNewsList)
    }
    
    /// Method to get the smallest news image from the related images.
    /// It takes an array of NewsResponseModel.RelatedImage and returns the smallest NewsImage.
    func getSmallestNewsImage(images: [NewsResponseModel.RelatedImage]) -> NewsImage? {
        // Find the image with the smallest width in the related images array.
        guard let smallestImage = images.min(by: { $0.width < $1.width }) else {
            return nil
        }
        
        // Get the URL for the smallest image.
        let imageURl = getURLForSmallestImage(smallestImage)
           
        // Create the NewsStories object using the extracted properties and the sorted news list.
        return NewsImage (id: smallestImage.id,
                          assetType: AssetType(rawValue: smallestImage.assetType) ?? .image,
                          imageUrl: imageURl,
                          type: smallestImage.type,
                          description: smallestImage.description,
                          lastModified: smallestImage.lastModified,
                          photographer: smallestImage.photographer,
                          timeStamp: smallestImage.timeStamp,
                          height: smallestImage.height,
                          width: smallestImage.width)
    }
    
    /// Method to get the URL for the smallest image from the related image.
    /// It takes a NewsResponseModel.RelatedImage and returns the URL as a String.
    func getURLForSmallestImage(_ relatedImage: NewsResponseModel.RelatedImage) -> String {
        // Check for the presence of the smallest image URL in the related image object.
        if let image = relatedImage.thumbnail {
            return image
        } else if let image = relatedImage.thumbnail2x {
            return image
        } else if let image = relatedImage.large {
            return image
        } else if let image =  relatedImage.large2x {
            return image
        } else if let image = relatedImage.large2x {
            return image
        } else if let image = relatedImage.xLarge {
            return image
        } else if let image = relatedImage.xLarge2x {
            return image
        }
        
        // If none of the above image URLs are available, return the default URL from the related image.
        return relatedImage.url
    }
}
    
   


