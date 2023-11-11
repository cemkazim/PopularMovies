//
//  MovieListViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SnapKit

final class MovieListViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var movieListTableView: DynamicTableView!
    private var viewModel: MovieListViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupViewModel() {
        viewModel = MovieListViewModel()
        viewModel.delegate = self
    }
    
    private func setupView() {
        setupTableView()
        viewModel.getPopularMovieListData()
    }
    
    private func setupTableView() {
        movieListTableView = DynamicTableView(frame: .zero, style: .plain)
        movieListTableView.separatorStyle = .none
        movieListTableView.backgroundColor = .clear
        view.addSubview(movieListTableView)
        movieListTableView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
        movieListTableView.register(MovieListTableViewCell.self,
                           forCellReuseIdentifier: MovieListTableViewCell.cellID)
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.cellID, for: indexPath) as? MovieListTableViewCell {
            cell.updateUI(with: viewModel.movieList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieId = viewModel.movieList[indexPath.row].id {
//            let movieDetailViewController = MovieDetailViewController()
//            movieDetailViewController.selectedMovieId = movieId
//            navigationController?.pushViewController(movieDetailViewController, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MovieListViewController: MovieListViewModelDelegate {
    
    func reloadList() {
        DispatchQueue.main.async {
            self.movieListTableView.reloadData()
        }
    }
}
