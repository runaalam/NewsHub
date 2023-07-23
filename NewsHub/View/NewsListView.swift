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
                        Link(destination: URL(string: news.newsUrl)!, label: {
                            NewsRow(news: news)
                        })
                    }
                } else if let error = newsViewModel.errorText {
                    Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.red)
                    Text("\(error)")
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
    @StateObject private var imageCache = ImageCache()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let cachedImage = imageCache.getImage(forKey: news.newsUrl){
                cachedImage
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
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
                    ZStack {
                        Color.gray
                        ProgressView("")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }
                .frame(height: 200)
            }
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
