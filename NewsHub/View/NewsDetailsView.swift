//
//  NewsDetailsView.swift
//  NewsHub
//
//  Created by Runa Alam on 17/7/2023.
//

import Foundation
import SwiftUI

struct NewsDetailsView: View {
    @StateObject var newsDetailsViewModel: NewsDetailsViewModel
   
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: newsDetailsViewModel.news.newsImage!.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                Color.gray
            }
            .frame(height: 200)
            
            Text(newsDetailsViewModel.news.headLine)
                .font(.title)
            Text(newsDetailsViewModel.news.byLine)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(newsDetailsViewModel.news.abstract)
                .font(.body)
                .padding(.top, 8)
            Link(destination: URL(string: newsDetailsViewModel.news.newsUrl)!, label: {
                Text("Read this article")
            })
            .padding(.top, 8)
        }
        .padding()
        .navigationTitle("News Details")
    }
}

