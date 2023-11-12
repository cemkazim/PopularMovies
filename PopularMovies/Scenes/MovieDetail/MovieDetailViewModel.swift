//
//  MovieDetailViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import Foundation

final class MovieDetailViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    private var movie: MovieDetailModel
    
    // MARK: - Initializers
    
    init(movie: MovieDetailModel) {
        self.movie = movie
    }
    
    // MARK: - Methods
    
    func getMovie() -> MovieDetailModel {
        return movie
    }
}
