//
//  BasicImageCache.swift
//  NewsHub
//
//  Created by Runa Alam on 16/7/2023.
//

import Foundation

protocol ImageCache {
    func cacheImageURL(_ url: String, forNewsId newsId: Int)
    func getImageURL(forNewsId newsId: Int) -> String?
}

class BasicImageCache: ImageCache {
    private var imageCache: [Int: String] = [:]
    
    func cacheImageURL(_ url: String, forNewsId newsId: Int) {
        imageCache[newsId] = url
    }
    
    func getImageURL(forNewsId newsId: Int) -> String? {
        return imageCache[newsId]
    }
}
