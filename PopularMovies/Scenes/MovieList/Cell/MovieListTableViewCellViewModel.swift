//
//  MovieListTableViewCellViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 12.11.2023.
//

import RxRelay

class MovieListTableViewCellViewModel {
    
    // MARK: - Properties
    
    let movieNameSubject = BehaviorRelay<String>(value: "")
    let movieRatingSubject = BehaviorRelay<String>(value: "")
    let movieImageURLSubject = BehaviorRelay<URL?>(value: nil)
    
    // MARK: - Initializers
    
    init(movie: MovieDetailModel) {
        movieNameSubject.accept(movie.name ?? "")
        let ratingText = "MovieRatingTitle".localized + "\(movie.rating ?? 0)" + "/10"
        movieRatingSubject.accept(ratingText)
        let imageURL = URL(string: movie.posterPath ?? "")
        movieImageURLSubject.accept(imageURL)
    }
}
