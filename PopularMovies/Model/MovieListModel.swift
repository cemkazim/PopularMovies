//
//  MovieListModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import Foundation

struct MovieListModel: Decodable {
    let page: Int?
    let list: [MovieDetailModel]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case list = "results"
    }
}

struct MovieDetailModel: Decodable {
    let name: String?
    let posterPath: String?
    let id: Int?
    let rating: Double?
    let overview: String?
    let firstAirDate: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "original_name"
        case id
        case posterPath = "poster_path"
        case rating = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
    }
}
