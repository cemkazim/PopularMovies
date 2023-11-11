//
//  MovieListViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MovieListViewController: BaseViewController<MovieListViewModel> {
    
    // MARK: - Properties
    
    private var movieListTableView: DynamicTableView!
    private var disposeBag = DisposeBag()
    
    // MARK: - Methods
    
    override func setupView() {
        movieListTableView = DynamicTableView(frame: .zero, style: .plain)
        movieListTableView.separatorStyle = .none
        movieListTableView.backgroundColor = .clear
        view.addSubview(movieListTableView)
        movieListTableView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
        movieListTableView.register(MovieListTableViewCell.self,
                                   forCellReuseIdentifier: MovieListTableViewCell.cellID)
    }
    
    override func bindViewModel() {
        viewModel.getPopularMovieListData()
        viewModel.movieListObservable
            .bind(to: movieListTableView.rx.items(cellIdentifier: MovieListTableViewCell.cellID,
                                                  cellType: MovieListTableViewCell.self)) { index, element, cell in
                cell.updateUI(with: element)
            }
            .disposed(by: disposeBag)
        Observable.combineLatest(movieListTableView.rx.itemSelected, viewModel.movieListObservable)
            .subscribe(onNext: { [weak self] (indexPath, movies: [MovieDetailModel]) in
                guard let self = self else { return }
                let movieDetailViewModel = MovieDetailViewModel(movie: movies[indexPath.row])
                let movieDetailViewController = MovieDetailViewController(viewModel: movieDetailViewModel)
                self.navigationController?.pushViewController(movieDetailViewController, animated: true)
            })
            .disposed(by: disposeBag)
        Observable.combineLatest(movieListTableView.rx.willDisplayCell, viewModel.movieListObservable)
            .subscribe { [weak self] (cellData, movies: [MovieDetailModel]) in
                guard let self = self else { return }
                if movies.count == self.viewModel.getPageItemCount() * self.viewModel.getCurrentPageNumber() {
                    if cellData.indexPath.row == movies.count - 1 {
                        self.viewModel.increasePageCount()
                        self.viewModel.getPopularMovieListData()
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
