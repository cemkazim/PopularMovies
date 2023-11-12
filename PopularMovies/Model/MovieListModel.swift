//
//  MovieListModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import Foundation

class MovieListModel: Decodable {
    
    // MARK: - Properties
    
    var page: Int? = nil
    var list: [MovieDetailModel]? = nil
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case page
        case list = "results"
    }
    
    // MARK: - Initializers
    
    init(page: Int? = nil, list: [MovieDetailModel]? = nil) {
        self.page = page
        self.list = list
    }
}

class MovieDetailModel: Decodable {
    
    // MARK: - Properties
    
    var name: String? = nil
    var posterPath: String? = nil
    var id: Int? = nil
    var rating: Double? = nil
    var overview: String? = nil
    var firstAirDate: String? = nil
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case name = "original_name"
        case id
        case posterPath = "poster_path"
        case rating = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
    }
    
    // MARK: - Initializers
    
    init(name: String? = nil, posterPath: String? = nil, id: Int? = nil, rating: Double? = nil, overview: String? = nil, firstAirDate: String? = nil) {
        self.name = name
        self.posterPath = posterPath
        self.id = id
        self.rating = rating
        self.overview = overview
        self.firstAirDate = firstAirDate
    }
}
