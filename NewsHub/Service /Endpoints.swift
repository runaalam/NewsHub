//
//  Endpoints.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import Foundation

protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
}

enum Endpoint: APIEndpoint {
    case fetchNews
    
    var baseURL: String {
        return "https://bruce-v2-mob.fairfaxmedia.com.au/1/alfred_live"
    }
    
    var path: String {
        switch self {
        case .fetchNews:
            return "/67184313/offline/afr"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
}
