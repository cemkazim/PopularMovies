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
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    override func setupView() {
        super.setupView()
        movieListTableView = DynamicTableView(frame: .zero, style: .plain)
        movieListTableView.separatorStyle = .none
        movieListTableView.backgroundColor = .clear
        mainView.addSubview(movieListTableView)
        movieListTableView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
        movieListTableView.register(MovieListTableViewCell.self,
                                   forCellReuseIdentifier: MovieListTableViewCell.cellID)
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel else { return }
        let fetchListSubject = BehaviorRelay<()>(value: ())
        let output = viewModel.transform(input: MovieListViewModel.Input(fetchMovieListTrigger: fetchListSubject))
        output.movieListObservable
            .bind(to: movieListTableView.rx.items(cellIdentifier: MovieListTableViewCell.cellID,
                                                  cellType: MovieListTableViewCell.self)) { index, element, cell in
                let viewModel = MovieListTableViewCellViewModel(movie: element)
                cell.bindData(viewModel: viewModel)
            }
            .disposed(by: disposeBag)
        Observable.combineLatest(movieListTableView.rx.itemSelected, output.movieListObservable)
            .subscribe(onNext: { [weak self] (indexPath, movies: [MovieDetailModel]) in
                guard let self = self else { return }
                let movieDetailViewModel = MovieDetailViewModel(movie: movies[indexPath.row])
                let movieDetailViewController = MovieDetailViewController(viewModel: movieDetailViewModel)
                self.navigationController?.pushViewController(movieDetailViewController, animated: true)
            })
            .disposed(by: disposeBag)
        Observable.combineLatest(movieListTableView.rx.willDisplayCell, output.movieListObservable)
            .subscribe { (cellData, movies: [MovieDetailModel]) in
                if movies.count == viewModel.getPageItemCount() * viewModel.getCurrentPageNumber() {
                    if cellData.indexPath.row == movies.count - 1 {
                        viewModel.increasePageNumber()
                        fetchListSubject.accept(())
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
