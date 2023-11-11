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
    func getPopularMovieURLString(pageId: Int) -> URL? {
        var components = baseURLComponents()
        components.path = "/3/tv/popular"
        components.queryItems?.append(URLQueryItem(name: "page", value: String(pageId)))
        return components.url
    }
    
    /// Description: Generic URL components creator.
    func baseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US")
        ]
        return components
    }
}
