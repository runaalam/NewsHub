//
//  NewsStories.swift
//  NewsHub
//
//  Created by Runa Alam on 16/7/2023.
//

import Foundation

public struct NewsStories: Equatable {
    let id: Int
    let assetType: AssetType
    let url: String
    let lastModified: TimeInterval
    let timeStamp: TimeInterval
    let displayName: String
    let onTime: TimeInterval
    let news: [News]
}

public struct News: Equatable {
    let newsId: Int
    let newsAssetType: AssetType
    let newsUrl:String
    let newsLastModified: TimeInterval
    let newsTimeStamp: TimeInterval
    let headLine: String
    let abstract: String
    let extendedAbstract: String
    let byLine: String
    let newsImage: NewsImage?
    let newsBody: String
}

public struct NewsImage: Equatable {
    let id: Int
    let assetType: AssetType
    let imageUrl: String
    let type: String
    let description: String
    let lastModified: TimeInterval
    let photographer: String
    let timeStamp: TimeInterval
    let height: Int
    let width: Int
}

public enum AssetType: String {
    case article = "ARTICLE"
    case image = "IMAGE"
    case assetList = "ASSET_LIST"
}
