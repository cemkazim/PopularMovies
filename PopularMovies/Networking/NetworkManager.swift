//
//  NetworkManager.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Description: Request the API data with parameters (T is a decodable model).
    /// - Parameters:
    ///   - url: Formatted url for API data.
    ///   - method: Any HTTPMethod.
    ///   - parameters: Request body (optional).
    ///   - onComplete: Pass the data with completion.
    func request<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters? = nil, onComplete: @escaping (Result<T, Error>) -> ()) {
        AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default).response { (response) in
            guard let remoteData = response.data else { return }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: remoteData)
                onComplete(.success(decodedData))
            } catch let error {
                onComplete(.failure(error))
            }
        }
    }
}
