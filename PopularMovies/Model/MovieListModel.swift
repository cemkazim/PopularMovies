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
    let title: String?
    let posterPath: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case title, id
        case posterPath = "poster_path"
    }
}
