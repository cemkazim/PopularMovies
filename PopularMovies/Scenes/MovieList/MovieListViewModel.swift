//
//  MovieListViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import RxSwift

// MARK: - MovieListViewModelDelegate

protocol MovieListViewModelDelegate: AnyObject {
    func reloadList()
}

final class MovieListViewModel {
    
    // MARK: - Properties
    
    private var pageCount = 1
    private(set) var movieList: [MovieDetailModel] = []
    private var disposeBag = DisposeBag()
    weak var delegate: MovieListViewModelDelegate?
    
    // MARK: - Methods
    
    func getPopularMovieListData() {
        guard let url = MovieAPI.shared.getPopularMovieURLString(pageId: pageCount) else { return }
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
    
    private func handle(_ movieList: [MovieDetailModel]) {
        for movie in movieList {
            let resultModel = MovieDetailModel(name: movie.name,
                                               posterPath: imageBaseURL + (movie.posterPath ?? ""),
                                               id: movie.id,
                                               rating: movie.rating)
            self.movieList.append(resultModel)
        }
        delegate?.reloadList()
    }
}
