//
//  NewsView.swift
//  NewsHub
//
//  Created by Runa Alam on 16/7/2023.
//

import Foundation
import SwiftUI

struct NewsListView: View {
    @ObservedObject var newsViewModel: NewsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if newsViewModel.isLoading {
                    ProgressView("Loading...")
                } else if let newsStories = newsViewModel.newsStories {
                    List(newsStories.news, id: \.newsId) { news in
                        NavigationLink(destination: NewsDetailsView(news: news)) {
                            NewsRow(news: news)
                        }
                    }
                } else if let error = newsViewModel.error {
                    Text("Error: \(error.localizedDescription)")
                }
            }
            .onAppear {
                newsViewModel.fetchAllNews()
            }
            .navigationTitle("News Hub")
        }
    }
}

struct NewsRow: View {
    let news: News
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(news.headLine)
                .font(.headline)
            Text(news.byLine)
                .font(.subheadline)
            Text(news.abstract)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct NewsDetailsView: View {
    let news: News
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(news.headLine)
                .font(.title)
            Text(news.byLine)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(news.abstract)
                .font(.body)
                .padding(.top, 8)
        }
        .padding()
        .navigationTitle("News Details")
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        let newsViewModel = NewsViewModel()
        NewsListView(newsViewModel: newsViewModel)
    }
}

