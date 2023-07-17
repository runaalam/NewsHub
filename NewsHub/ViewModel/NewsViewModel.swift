//
//  NewsViewModel.swift
//  NewsHub
//
//  Created by Runa Alam on 16/7/2023.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var newsStories: NewsStories?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    let newsAPIClient = NewsAPIClient()
    let imageCache = BasicImageCache()
    let newsService: NewsService
    
    init() {
        self.newsService = NewsService(apiClient: newsAPIClient, imageCache: imageCache)
    }
    
    func fetchAllNews() {
        isLoading = true
        
        newsService.fetchAllNews { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let newsStories):
                    let sortedNews = newsStories.news.sorted(by: { $0.newsTimeStamp > $1.newsTimeStamp })
                    let sortedNewsStories = NewsStories(id: newsStories.id,
                                                        assetType: newsStories.assetType,
                                                        url: newsStories.url,
                                                        lastModified: newsStories.lastModified,
                                                        timeStamp: newsStories.timeStamp,
                                                        displayName: newsStories.displayName,
                                                        onTime: newsStories.onTime,
                                                        news: sortedNews)
                    self.newsStories = sortedNewsStories
                    self.error = nil
                case .failure(let error):
                    self.newsStories = nil
                    self.error = error
                }
            }
        }
    }

    func getImageUrl(_ newsId: Int) -> String? {
        return imageCache.getImageURL(forNewsId: newsId)
    }

}

class NewsDetailsViewModel: ObservableObject {
    @Published var news: News
    private let imageCache: ImageCache
    
    init(news: News, imageCache: ImageCache) {
        self.news = news
        self.imageCache = imageCache
    }
    
    func getImageUrl() -> String? {
        return imageCache.getImageURL(forNewsId: news.newsId)
    }
}

