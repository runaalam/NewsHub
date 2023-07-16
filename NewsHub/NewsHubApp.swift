//
//  NewsHubApp.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import SwiftUI

@main
struct NewsHubApp: App {
    var body: some Scene {
        WindowGroup {
            let newsViewModel = NewsViewModel()
            NewsListView(newsViewModel: newsViewModel)
        }
    }
}
