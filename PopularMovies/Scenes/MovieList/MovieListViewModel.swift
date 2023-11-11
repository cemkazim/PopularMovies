//
//  MovieListViewModel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import Foundation

// MARK: - MovieListViewModelDelegate

protocol MovieListViewModelDelegate: AnyObject {
    func reloadList()
}

final class MovieListViewModel {
    
    // MARK: - Properties
    
    private var pageCount = 1
    private(set) var movieList: [MovieDetailModel] = []
    weak var delegate: MovieListViewModelDelegate?
    
    // MARK: - Methods
    
    func getPopularMovieListData() {
        let url = MovieAPI.shared.createPopularMovieURL(pageId: pageCount)
        guard let requestURL = url else { return }
        NetworkManager.shared.request(url: requestURL.absoluteString, method: .get) { [weak self] (result: Result<MovieListModel, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let movieList = response.list {
                    self.handle(movieList)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func handle(_ movieList: [MovieDetailModel]) {
        for movie in movieList {
            if let title = movie.title,
               let imageURL = movie.posterPath,
               let movieId = movie.id {
                let resultModel = MovieDetailModel(title: title,
                                                   posterPath: MovieAPI.shared.movieImageBaseURLPath + imageURL,
                                                   id: movieId)
                self.movieList.append(resultModel)
            }
        }
        delegate?.reloadList()
    }
}
