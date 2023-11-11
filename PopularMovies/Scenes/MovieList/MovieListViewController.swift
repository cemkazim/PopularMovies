//
//  MovieListViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    
    private var movieListCollectionView: UICollectionView!
    private var viewModel: MovieListViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel = MovieListViewModel()
        viewModel.delegate = self
    }
    
    // MARK: - Methods
    
    private func setupView() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .vertical
        movieListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        movieListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        movieListCollectionView.setCollectionViewLayout(layout, animated: true)
        movieListCollectionView.backgroundColor = .clear
        movieListCollectionView.backgroundView = UIView.init(frame: .zero)
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.popularMovieListCollectionViewCellID, for: indexPath) as? PopularMovieListCollectionViewCell {
            cell.setMovieData(popularMovieList: viewModel.movieList, starredMovieIdList: starredMovieIdList, indexPath: indexPath)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.movieList.count == viewModel.viewModel.getPageItemCount() * viewModel.getCurrentPageNumber() {
            if indexPath.row == viewModel.movieList.count - 1 {
                loadMoreButton.isHidden = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieId = viewModel.movieList[indexPath.row].id {
            let movieDetailViewController = MovieDetailViewController()
            movieDetailViewController.selectedMovieId = movieId
            navigationController?.pushViewController(movieDetailViewController, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MovieListViewController: MovieListViewModelDelegate {
    
    func getMovieList(_ list: [MovieDetailModel]) {
        <#code#>
    }
}
