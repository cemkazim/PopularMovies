//
//  MovieListViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import RxSwift
import RxRelay

final class MovieListViewModel: BaseViewModel, BaseViewModelType {
    
    // MARK: - Bindings
    
    struct Input {
        let fetchMovieListTrigger: BehaviorRelay<()>
    }

    struct Output {
        let movieListObservable: Observable<[MovieDetailModel]>
    }
    
    // MARK: - Properties
    
    private var pageNumber = 1
    private var movieList: [MovieDetailModel] = []
    private var movieListSubject = PublishSubject<[MovieDetailModel]>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        input.fetchMovieListTrigger
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.getPopularMovieListData()
            }
            .disposed(by: disposeBag)
        return Output(movieListObservable: movieListSubject.asObservable())
    }
    
    private func getPopularMovieListData() {
        guard let url = MovieAPI.shared.getPopularMovieURLString(pageId: pageNumber) else { return }
        NetworkManager.shared.request(url: url, method: .get)
            .subscribe { [weak self] (event: Result<MovieListModel, Error>) in
                guard let self = self else { return }
                switch event {
                case .success(let result):
                    if let movieList = result.list {
                        self.handle(movieList)
                    }
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func handle(_ list: [MovieDetailModel]) {
        for movie in list {
            let resultModel = MovieDetailModel(name: movie.name,
                                               posterPath: imageBaseURL + (movie.posterPath ?? ""),
                                               id: movie.id,
                                               rating: movie.rating,
                                               overview: movie.overview,
                                               firstAirDate: movie.firstAirDate)
            movieList.append(resultModel)
        }
        movieListSubject.onNext(movieList)
    }
    
    func increasePageNumber() {
        pageNumber += 1
    }
    
    func getCurrentPageNumber() -> Int {
        return pageNumber
    }
    
    func getPageItemCount() -> Int {
        return 20
    }
}
