//
//  NewsDetailsView.swift
//  NewsHub
//
//  Created by Runa Alam on 17/7/2023.
//

import Foundation
import SwiftUI

struct NewsDetailsView: View {
    let news: News
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: news.newsImage!.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                Color.gray
            }
            
            Text(news.headLine)
                .font(.title)
            Text(news.byLine)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(news.newsBody)
                .font(.body)
                .padding(.top, 8)
        }
        .padding()
        .navigationTitle("News Details")
    }
}

