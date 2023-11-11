//
//  MovieListViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit

final class MovieListViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var movieListCollectionView: UICollectionView!
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
        setupCollectionView()
        viewModel.getPopularMovieListData()
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
        movieListCollectionView.register(MovieListCollectionViewCell.self,
                                         forCellWithReuseIdentifier: MovieListCollectionViewCell.cellID)
        view.addSubview(movieListCollectionView)
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.cellID, for: indexPath) as? MovieListCollectionViewCell {
            cell.updateUI(with: viewModel.movieList[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
            self.movieListCollectionView.reloadData()
        }
    }
}
