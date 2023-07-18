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
                    self.newsStories = newsStories
                    self.error = nil
                case .failure(let error):
                    self.newsStories = nil
                    self.error = error
                }
            }
        }
    }
}

