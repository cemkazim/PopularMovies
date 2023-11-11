//
//  MovieListViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import RxSwift

final class MovieListViewModel {
    
    // MARK: - Properties
    
    private var pageNumber = 1
    private var pageItemCount = 20
    private var movieList: [MovieDetailModel] = []
    private var movieListSubject = BehaviorSubject<[MovieDetailModel]>(value: [])
    var movieListObservable: Observable<[MovieDetailModel]> {
        return movieListSubject.asObservable()
    }
    private var disposeBag = DisposeBag()
    
    // MARK: - Methods
    
    func getPopularMovieListData() {
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
    
    func increasePageCount() {
        pageNumber += 1
    }
    
    func getCurrentPageNumber() -> Int {
        return pageNumber
    }
    
    func getPageItemCount() -> Int {
        return pageItemCount
    }
}
