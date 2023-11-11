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

final class MovieListViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var movieListTableView: DynamicTableView!
    private var viewModel: MovieListViewModel!
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupView()
        listenObservables()
    }
    
    // MARK: - Methods
    
    private func setupViewModel() {
        viewModel = MovieListViewModel()
    }
    
    private func setupView() {
        movieListTableView = DynamicTableView(frame: .zero, style: .plain)
        movieListTableView.separatorStyle = .none
        movieListTableView.backgroundColor = .clear
        view.addSubview(movieListTableView)
        movieListTableView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
        movieListTableView.register(MovieListTableViewCell.self,
                                   forCellReuseIdentifier: MovieListTableViewCell.cellID)
        viewModel.getPopularMovieListData()
    }
    
    private func listenObservables() {
        viewModel.movieListObservable
            .bind(to: movieListTableView.rx.items(cellIdentifier: "MovieListTableViewCell",
                                                  cellType: MovieListTableViewCell.self)) { index, element, cell in
                cell.updateUI(with: element)
            }
            .disposed(by: disposeBag)
        Observable.combineLatest(movieListTableView.rx.itemSelected, viewModel.movieListObservable)
            .subscribe(onNext: { [weak self] (indexPath, movies: [MovieDetailModel]) in
                guard let self = self else { return }
                let movieDetailViewController = MovieDetailViewController()
                let movieDetailViewModel = MovieDetailViewModel(movie: movies[indexPath.row])
                movieDetailViewController.setupViewModel(movieDetailViewModel)
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
                        print("refetched!")
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
