//
//  MovieListTableViewCellViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 12.11.2023.
//

import RxSwift
import RxRelay

class MovieListTableViewCellViewModel {
    
    // MARK: - Properties
    
    let movieNameSubject: BehaviorRelay<String>
    let movieRatingSubject: BehaviorRelay<String>
    let movieImageURLSubject: BehaviorRelay<URL?>
    
    // MARK: - Initializers
    
    init(movie: MovieDetailModel) {
        let nameText = "MovieNameTitle".localized + (movie.name ?? "")
        movieNameSubject = BehaviorRelay<String>(value: nameText)
        let ratingText = "MovieRatingTitle".localized + "\(movie.rating ?? 0)"
        movieRatingSubject = BehaviorRelay<String>(value: ratingText)
        let imageURL = URL(string: movie.posterPath ?? "")
        movieImageURLSubject = BehaviorRelay<URL?>(value: imageURL)
    }
}
