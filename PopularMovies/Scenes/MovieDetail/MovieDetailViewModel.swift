//
//  MovieDetailViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import Foundation

final class MovieDetailViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    private(set) var movie: MovieDetailModel
    
    // MARK: - Initializers
    
    init(movie: MovieDetailModel) {
        self.movie = movie
    }
}
