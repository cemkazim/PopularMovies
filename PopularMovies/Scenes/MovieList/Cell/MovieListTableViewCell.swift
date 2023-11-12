//
//  MovieListCollectionViewCell.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SDWebImage
import SnapKit
import RxSwift

class MovieListTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private var movieImageView: UIImageView!
    private var movieNameLabel = CommonLabel(style: .title)
    private var movieRatingLabel = CommonLabel(style: .content)
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieNameLabel.text = nil
        movieRatingLabel.text = nil
    }
    
    override func setupView() {
        selectionStyle = .none
        setupMovieImageView()
        setupMovieNameLabel()
        setupMovieRatingLabel()
    }
    
    func bindData(viewModel: MovieListTableViewCellViewModel) {
        viewModel.movieNameSubject
            .bind(to: movieNameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.movieRatingSubject
            .bind(to: movieRatingLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.movieImageURLSubject
            .subscribe(onNext: { [weak self] imageURL in
                guard let self = self else { return }
                self.movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                self.movieImageView.sd_setImage(with: imageURL)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupMovieImageView() {
        movieImageView = UIImageView()
        movieImageView.contentMode = .scaleAspectFit
        contentView.addSubview(movieImageView)
        movieImageView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.centerX.equalToSuperview()
            view.width.equalTo(150)
            view.height.equalTo(225)
        }
    }
    
    private func setupMovieNameLabel() {
        contentView.addSubview(movieNameLabel)
        movieNameLabel.snp.makeConstraints { view in
            view.top.equalTo(movieImageView.snp.bottom).offset(20)
            view.left.equalToSuperview().offset(20)
            view.right.equalToSuperview().offset(-20)
        }
    }
    
    private func setupMovieRatingLabel() {
        movieRatingLabel.textAlignment = .center
        contentView.addSubview(movieRatingLabel)
        movieRatingLabel.snp.makeConstraints { view in
            view.top.equalTo(movieNameLabel.snp.bottom).offset(20)
            view.left.equalToSuperview().offset(20)
            view.right.bottom.equalToSuperview().offset(-20)
        }
    }
}
