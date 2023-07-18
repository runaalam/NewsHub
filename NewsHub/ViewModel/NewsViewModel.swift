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
    let newsService: NewsService
    
    init() {
        self.newsService = NewsService(apiClient: newsAPIClient)
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
}

