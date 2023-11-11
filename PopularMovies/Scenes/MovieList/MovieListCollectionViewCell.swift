//
//  MovieListCollectionViewCell.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var movieNameLabel: UILabel!
    private var movieImageView: UIImageView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        setupMovieNameLabel()
        setupMovieImageView()
        setupConstraints()
    }
    
    private func setupMovieImageView() {
        movieImageView = UIImageView()
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.contentMode = .scaleAspectFit
        addSubview(movieImageView)
    }
    
    private func setupMovieNameLabel() {
        movieNameLabel = UILabel()
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.font = UIFont.systemFont(ofSize: 16)
        movieNameLabel.numberOfLines = 2
        movieNameLabel.textColor = .black
        movieNameLabel.textAlignment = .left
        addSubview(movieNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieImageView.widthAnchor.constraint(equalToConstant: 150),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            movieImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            movieNameLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setMovieData(movieList: [MovieDetailModel], indexPath: IndexPath) {
        movieNameLabel.text = movieList[indexPath.row].title
        movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        movieImageView.sd_setImage(with: URL(string: movieList[indexPath.row].posterPath ?? ""))
    }
}
