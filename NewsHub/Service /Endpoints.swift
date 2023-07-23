//
//  Endpoints.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import Foundation

/// APIEndpoint is a protocol that defines the basic properties required for an API endpoint.
/// It declares three properties:
/// 1. baseURL: A string representing the base URL of the API.
/// 2. path: A string representing the specific endpoint path.
/// 3. url: A URL formed by combining the baseURL and the endpoint path.
protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
}


/// Endpoint is an enumeration that adopts the APIEndpoint protocol.
/// It provides cases for different API endpoints, such as fetchNews.
enum Endpoint: APIEndpoint {
    case fetchNews
    
    // baseURL specifies the base URL of the API for all cases of the Endpoint enumeration.
    var baseURL: String {
        return "https://bruce-v2-mob.fairfaxmedia.com.au/1/alfred_live"
    }
    
    // path specifies the specific endpoint path for each case of the Endpoint enumeration.
    var path: String {
        switch self {
        case .fetchNews:
            return "/67184313/offline/afr"
        }
    }
    
    // url returns the URL formed by combining the baseURL and the endpoint path for each case.
    var url: URL? {
        return URL(string: baseURL + path)
    }
}
