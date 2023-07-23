//
//  NewsViewModel.swift
//  NewsHub
//
//  Created by Runa Alam on 16/7/2023.
//

import Foundation
import SwiftUI

// NewsViewModel is a ViewModel class responsible for managing the data related to news articles.
// It has three @Published properties:
// 1. newsStories: Stores the fetched NewsStories object containing a list of news articles.
// 2. isLoading: A boolean flag that indicates whether data is currently being fetched from the server.
// 3. errorText: Contains the error message in case of a failure while fetching news articles.

class NewsViewModel: ObservableObject {
    @Published var newsStories: NewsStories?
    @Published var isLoading: Bool = true
    @Published var errorText: String?
    
    // The ImageCache to store and manage cached images.
    public var imageCache = ImageCache()

    // Instances of NewsAPIClient and NewsService to fetch news articles from the API.
    public var newsAPIClient = NewsAPIClient()
    public var newsService: NewsService
    
    // Initialises the NewsViewModel with a NewsService that uses the NewsAPIClient for API requests.
    init() {
        self.newsService = NewsService(apiClient: newsAPIClient)
    }
    
    // Function to fetch all news articles.
    func fetchAllNews() {
        
        // Call the fetchAllNews method of the NewsService to fetch the news articles.
        newsService.fetchAllNews { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
               
                
                switch result {
                case .success(let newsStories):
                    self.newsStories = newsStories
                    self.errorText = nil
                    // Once the data is fetched, set isLoading to false to hide the loading indicator.
                    self.isLoading = false
                case .failure(let error):
                    // Once the data is fetched, set isLoading to false to hide the loading indicator and show error message 
                    self.isLoading = false
                    self.newsStories = nil
                    switch error {
                    case .message(let errorMessage):
                        self.errorText = errorMessage
                    default:
                        self.errorText = "Something wrong try again!"
                    }
                }
            }
        }
    }
}

