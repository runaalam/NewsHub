//
//  NewsDetailsViewModel.swift
//  NewsHub
//
//  Created by Runa Alam on 17/7/2023.
//

import Foundation

class NewsDetailsViewModel: ObservableObject {
    @Published var news: News
    
    init(news: News) {
        self.news = news
    }
}
