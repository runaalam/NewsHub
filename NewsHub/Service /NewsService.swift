//
//  NewsService.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import Foundation

struct NewsService {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    typealias CompletionHandler = (Result<NewsStories, Error>) -> Void
    
    func fetchAllNews(completion: @escaping CompletionHandler) {
        let endpoint = Endpoint.fetchNews
        
        apiClient.fetchData(from: endpoint.url?.absoluteString ?? "", responseType: NewsResponseModel.self) { result in
            switch result {
            case .success(let response):
                do {
                    let newsStories = try self.mapNewsData(response)
                    completion(.success(newsStories))
                } catch {
                    completion(.failure(error))
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
            let newsTimeStamp = String(asset.timeStamp)
            let headLine = asset.headline
            let abstract = asset.theAbstract
            let byLine = asset.byLine
            
            let newsImage: NewsImage?
            
            let newsItem = News(newsId: newsId,
                                newsAssetType: newsAssetType,
                                newsUrl: newsUrl,
                                newsLastModified: newsLastModified,
                                newsTimeStamp: newsTimeStamp,
                                headLine: headLine,
                                abstract: abstract,
                                byLine: byLine,
                                newsImage: nil)
            
            newsList.append(newsItem)
        }
        
        
        return NewsStories(id: id,
                           assetType: assetType,
                           url: url,
                           lastModified: lastModified,
                           timeStamp: timeStamp,
                           displayName: displayName,
                           onTime: onTime,
                           news: newsList)
    }
}
    
   


