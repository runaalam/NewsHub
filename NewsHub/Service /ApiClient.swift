//
//  ApiClient.swift
//  NewsHub
//
//  Created by Runa Alam on 14/7/2023.
//

import Foundation

/// APIClient is a protocol that defines the methods required for making API requests and handling responses.
/// It declares one method fetchData which is used to fetch data from the specified endpoint.
protocol APIClient {
    // The fetchData method is used to make an API request and decode the response into the specified type.
    // It takes the following parameters:
    // - endpoint: A string representing the API endpoint to request data from.
    // - responseType: The type of the expected response, which must conform to Decodable.
    // - completion: A closure that takes a Result enum as a parameter. The Result contains either the decoded
    // - response data or an APIError in case of failure.

    func fetchData<T: Decodable>(from endpoint: String, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}

/// APIError is an enumeration that conforms to Error and Equatable.
/// It provides different cases to represent different errors that can occur during API requests and responses.
enum APIError: Error, Equatable {
    case invalidURL
    case requestFailed
    case decodingFailed
    case responseError
    case message(String)
}

/// NewsAPIClient is a class that conforms to the APIClient protocol.
/// It implements the fetchData method to fetch data from the specified endpoint using URLSession.
class NewsAPIClient: APIClient {

    func fetchData<T: Decodable>(from endpoint: String, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // Create a data task to make the API request.
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(APIError.message(error.localizedDescription)))
                return
            }
            
            // Check if the HTTP response is valid (status code 200-299).
            guard self.isHTTPResponseValid(response) else {
                completion(.failure(APIError.responseError))
                return
            }
            
            // Ensure that response data is not nil.
            guard let data = data else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            // Decode the response data into the specified response type.
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(APIError.decodingFailed))
            }
        }.resume()
    }
    
    /// Helper method to check if the HTTP response is valid (status code 200-299).
    /// It takes the response as an input and returns a boolean indicating if the response is valid.
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

