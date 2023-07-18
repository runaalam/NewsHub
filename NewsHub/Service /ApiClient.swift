//
//  ApiClient.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import Foundation

protocol APIClient {
    func fetchData<T: Decodable>(from endpoint: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

class NewsAPIClient: APIClient {

    func fetchData<T: Decodable>(from endpoint: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.requestFailed))
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
}
