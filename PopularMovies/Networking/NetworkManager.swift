//
//  NetworkManager.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import Alamofire
import RxSwift

enum NetworkError: Error {
    case invalidURL
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Description: Request the API data with parameters (T is a decodable model).
    /// - Parameters:
    ///   - url: Formatted url for API data.
    ///   - method: Any HTTPMethod.
    ///   - parameters: Request body (optional).
    ///   - onComplete: Pass the data with completion.
    func request<T: Decodable>(url: URL, method: HTTPMethod, parameters: Parameters? = nil) -> Single<T> {
        return Single.create { single in
            let headers = HTTPHeaders([
                HTTPHeader(name: "Authorization",
                           value: "Bearer \(accessToken)"),
                HTTPHeader(name: "accept",
                           value: "application/json")
            ])
            let request = AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
                .response { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data ?? Data())
                            single(.success(decodedData))
                        } catch let error {
                            single(.failure(error))
                        }
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
