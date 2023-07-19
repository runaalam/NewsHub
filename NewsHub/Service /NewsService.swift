//
//  NewsService.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import Foundation

class NewsService {
    let apiClient: APIClient
   
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    typealias CompletionHandler = (Result<NewsStories, APIError>) -> Void
    
    func fetchAllNews(completion: @escaping CompletionHandler) {
        let endpoint = Endpoint.fetchNews
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
    
    func mapNewsData(_ response: NewsResponseModel) throws -> NewsStories {
        let id = response.id
        let assetType = AssetType(rawValue: response.assetType) ?? .assetList
        let url = response.url
        let lastModified = response.lastModified
        let timeStamp = response.timeStamp
        let displayName = response.displayName
        let onTime = response.onTime
        
        var newsList: [News] = []
        
        for asset in response.assets {
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
            
            guard let newsImage: NewsImage = getSmallestNewsImage(images: asset.relatedImages) else {
                fatalError("Fail to get smallest image")
            }
            
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
            
            newsList.append(newsItem)
            
        }
        let sortedNewsList = newsList.sorted(by: { $0.newsTimeStamp > $1.newsTimeStamp })
        
        return NewsStories(id: id,
                           assetType: assetType,
                           url: url,
                           lastModified: lastModified,
                           timeStamp: timeStamp,
                           displayName: displayName,
                           onTime: onTime,
                           news: sortedNewsList)
    }
    
    func getSmallestNewsImage(images: [NewsResponseModel.RelatedImage]) -> NewsImage? {
        guard let smallestImage = images.min(by: { $0.width < $1.width }) else {
            return nil
        }
        
        let imageURl = getURLForSmallestImage(smallestImage)
            
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
    
    func getURLForSmallestImage(_ relatedImage: NewsResponseModel.RelatedImage) -> String {
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
        
        return relatedImage.url
    }
}
    
   


