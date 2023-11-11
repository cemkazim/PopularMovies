//
//  MovieListCollectionViewCell.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SDWebImage
import SnapKit

class MovieListTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private var movieImageView: UIImageView!
    private var movieNameLabel: UILabel!
    private var movieRatingLabel: UILabel!
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieNameLabel.text = nil
        movieRatingLabel.text = nil
    }
    
    private func setupView() {
        selectionStyle = .none
        movieImageView = UIImageView()
        movieImageView.contentMode = .scaleAspectFit
        contentView.addSubview(movieImageView)
        movieImageView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.centerX.equalToSuperview()
            view.width.equalTo(150)
            view.height.equalTo(225)
        }
        movieNameLabel = UILabel()
        movieNameLabel.font = UIFont.systemFont(ofSize: 16)
        movieNameLabel.textColor = .black
        movieNameLabel.textAlignment = .center
        movieNameLabel.numberOfLines = .zero
        contentView.addSubview(movieNameLabel)
        movieNameLabel.snp.makeConstraints { view in
            view.top.equalTo(movieImageView.snp.bottom).offset(20)
            view.left.equalToSuperview().offset(20)
            view.right.equalToSuperview().offset(-20)
        }
        movieRatingLabel = UILabel()
        movieRatingLabel.font = UIFont.systemFont(ofSize: 16)
        movieRatingLabel.textColor = .black
        movieRatingLabel.textAlignment = .center
        movieRatingLabel.numberOfLines = .zero
        contentView.addSubview(movieRatingLabel)
        movieRatingLabel.snp.makeConstraints { view in
            view.top.equalTo(movieNameLabel.snp.bottom).offset(20)
            view.left.equalToSuperview().offset(20)
            view.right.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func updateUI(with movie: MovieDetailModel) {
        movieNameLabel.text = "Name: \(movie.name ?? "")"
        movieRatingLabel.text = "Rating: \(movie.rating ?? 0)/10"
        movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        movieImageView.sd_setImage(with: URL(string: movie.posterPath ?? ""))
    }
}
