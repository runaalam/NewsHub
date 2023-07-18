//
//  NewsStories.swift
//  NewsHub
//
//  Created by Runa Alam on 16/7/2023.
//

import Foundation

public struct NewsStories {
    let id: Int
    let assetType: AssetType
    let url: String
    let lastModified: Int
    let timeStamp: Int
    let displayName: String
    let onTime: Int
    let news: [News]
}

public struct News {
    let newsId: Int
    let newsAssetType: AssetType
    let newsUrl:String
    let newsLastModified: Int
    let newsTimeStamp: String
    let headLine: String
    let abstract: String
    let extendedAbstract: String
    let byLine: String
    let newsImage: NewsImage?
    let newsBody: String
}

public struct NewsImage {
    let id: Int
    let assetType: AssetType
    let imageUrl: String
    let type: String
    let description: String
    let lastModified: Int
    let photographer: String
    let timeStamp: Int
    let height: Int
    let width: Int
}

public enum AssetType: String {
    case article = "ARTICLE"
    case image = "IMAGE"
    case assetList = "ASSET_LIST"
}

public enum ImageType: String {
    case afrArticleLead
    case afrArticleInline
    case articleLeadWide
    case wideLandscape
    case afrIndexLead
    case landscape
    case thumbnail
}
