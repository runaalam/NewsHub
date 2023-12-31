//
//  NewsResponse.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import Foundation

struct NewsResponseModel: Codable {
    let id: Int
    let assetType: String
    let url: String
    let lastModified: TimeInterval
    let timeStamp: TimeInterval
    let onTime: TimeInterval
    let displayName: String
    let assets: [Asset]
    
    struct Asset: Codable {
        let id: Int
        let assetType: String
        let url: String
        let lastModified: TimeInterval
        let timeStamp: TimeInterval
        let authors: [Author]
        let headline: String
        let byLine: String
        let theAbstract: String
        let body: String
        let extendedAbstract: String
        let numberOfComments: Int
        let acceptComments: Bool
        let companies: [Company]
        let categories: [Category]
        let relatedImages: [RelatedImage]
    }
    
    struct RelatedImage: Codable {
        let id: Int
        let assetType: String
        let url: String
        let authors: [Author]
        let lastModified: TimeInterval
        let sponsored: Bool
        let timeStamp: TimeInterval
        let description: String
        let type: String
        let height: Int
        let width: Int
        let photographer: String
        let xLarge2x: String?
        let xLarge: String?
        let large2x: String?
        let large: String?
        let thumbnail2x: String?
        let thumbnail: String?
        
        
        private enum CodingKeys: String, CodingKey {
            case id
            case assetType
            case url
            case authors
            case lastModified
            case sponsored
            case timeStamp
            case description
            case type
            case height
            case width
            case photographer
            case xLarge
            case xLarge2x = "xLarge@2x"
            case large
            case large2x = "large@2x"
            case thumbnail
            case thumbnail2x = "thumbnail@2x"
        }
    }

    struct Author: Codable {
        let email: String
        let name: String
        let title: String
        let relatedImages: [RelatedImage]
     
    }

    struct Company: Codable {
        let id: Int
        let abbreviatedName: String
        let companyCode: String
        let companyName: String
        let companyNumber: String
        let exchange: String
    }

    struct Category: Codable {
        let name: String
        let orderNum: Int
        let sectionPath: String
    }
}





