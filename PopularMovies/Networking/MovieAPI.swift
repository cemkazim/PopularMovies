//
//  MovieAPI.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import Foundation

class MovieAPI {
    
    static let shared = MovieAPI()
    
    private init() {}
    
    /// Description: Request the API data with parameters for popular movies.
    /// - Parameters:
    ///   - pageId: Page count of movie list.
    func createPopularMovieURL(pageId: Int) -> URL? {
        var components = baseURLComponents()
        components.path = "/3/movie/popular"
        components.queryItems?.append(URLQueryItem(name: "page", value: String(pageId)))
        return components.url
    }
    
    /// Description: Generic URL components creator.
    func baseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "api_key", value: "fc4147091caa304654154fb4dee3bf04")
        ]
        return components
    }
}

/// Description: Usable http methods.
enum HttpMethods: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
}
