//
//  ApiClient.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import Foundation

protocol APIClient {
    func fetchData<T: Decodable>(from endpoint: String, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}

enum APIError: Error, Equatable {
    case invalidURL
    case requestFailed
    case decodingFailed
    case responseError
    case message(String)
}

class NewsAPIClient: APIClient {

    func fetchData<T: Decodable>(from endpoint: String, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(APIError.message(error.localizedDescription)))
                return
            }
            
            guard self.isHTTPResponseValid(response) else {
                completion(.failure(APIError.responseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(APIError.decodingFailed))
            }
        }.resume()
    }
    
    func isHTTPResponseValid(_ response: URLResponse?) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        let statusCode = httpResponse.statusCode
       
        // Success - the status code is in the range 200-299
        if statusCode >= 200 && statusCode <= 299 {
            return true
        } else {
           return false
        }
    }
}

