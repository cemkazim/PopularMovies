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
            if let name = movie.name,
               let imageURL = movie.posterPath,
               let movieId = movie.id {
                let resultModel = MovieDetailModel(name: name,
                                                   posterPath: imageBaseURL + imageURL,
                                                   id: movieId)
                self.movieList.append(resultModel)
            }
        }
        delegate?.reloadList()
    }
}
