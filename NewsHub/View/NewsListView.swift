//
//  NewsView.swift
//  NewsHub
//
//  Created by Runa Alam on 16/7/2023.
//

import Foundation
import SwiftUI

// NewsListView displays a list of news articles fetched from the NewsViewModel.
// It shows a loading indicator while fetching data, displays the list of news articles in a List view,
// and handles error cases by showing an exclamation mark icon and an error message.

struct NewsListView: View {
    @ObservedObject var newsViewModel: NewsViewModel

    var body: some View {
        NavigationView {
            VStack {
                // Show a ProgressView with "Loading..." text if the newsViewModel is currently loading data.
                if newsViewModel.isLoading {
                    ProgressView("Loading...")
                } else if let newsStories = newsViewModel.newsStories {
                    // Display the list of news articles in a List view.
                    List(newsStories.news, id: \.newsId) { news in
                        // Each row in the list represents a news article and uses the NewsRow view.
                        Link(destination: URL(string: news.newsUrl)!, label: {
                            NewsRow(news: news)
                        })
                    }
                } else if let error = newsViewModel.errorText {
                    // If there's an error, show an exclamation mark icon and an error message in red.
                    Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.red)
                    Text("\(error)")
                }
            }
            .onAppear {
                // Fetch news articles when the view appears.
                newsViewModel.fetchAllNews()
            }
            .navigationTitle("News Hub")
        }
    }
}

// NewsRow displays a single news article in a VStack.
// It uses an ImageCache to load and cache the news article's image.
// If the image is available in the cache, it's displayed; otherwise, AsyncImage is used to load the image asynchronously.

struct NewsRow: View {
    let news: News
    @StateObject private var imageCache = ImageCache()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // If the image is available in the cache, display it using the cached Image.
            if let cachedImage = imageCache.getImage(forKey: news.newsUrl){
                cachedImage
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                // If the image is not available in the cache, use AsyncImage to load it asynchronously.
                AsyncImage(url: URL(string: news.newsImage!.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onAppear {
                            // Cache the image when it's loaded
                            imageCache.setImage(image, forKey: news.newsImage!.imageUrl)
                        }
                } placeholder: {
                    // Placeholder view shown while the image is loading.
                    ZStack {
                        Color.gray
                        ProgressView("")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }
                .frame(height: 200)
            }
            // Display the news article's headline, byline, and abstract.
            Text(news.headLine)
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Text(news.byLine)
                .font(.subheadline)
            Text(news.abstract)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        let newsViewModel = NewsViewModel()
        NewsListView(newsViewModel: newsViewModel)
    }
}
