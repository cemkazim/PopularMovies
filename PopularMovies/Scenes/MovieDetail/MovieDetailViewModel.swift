//
//  MovieDetailViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import RxRelay
import RxSwift

final class MovieDetailViewModel: BaseViewModel, BaseViewModelType {
    
    // MARK: - Bindings
    
    struct Input {
        let movieDetailSubject: BehaviorRelay<MovieDetailModel>
    }
    
    struct Output {
        let movieDetailObservable: Observable<MovieDetailModel>
    }
    
    // MARK: - Properties
    
    private var movie: MovieDetailModel
    private var disposeBag = DisposeBag()
    
    // MARK: - Initializers
    
    init(movie: MovieDetailModel) {
        self.movie = movie
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        input.movieDetailSubject.accept(movie)
        return Output(movieDetailObservable: input.movieDetailSubject.asObservable())
    }
}
