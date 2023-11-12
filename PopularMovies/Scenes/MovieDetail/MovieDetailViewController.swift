//
//  MovieDetailViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SnapKit
import SDWebImage
import RxSwift
import RxRelay

final class MovieDetailViewController: BaseViewController<MovieDetailViewModel> {
    
    // MARK: - Properties
    
    private var scrollableStackView: ScrollableStackView!
    private var labelStackView: UIStackView!
    private var posterImageView: UIImageView!
    private var nameLabel: UILabel!
    private var overviewLabel: UILabel!
    private var firstAirDateLabel: UILabel!
    private var ratingLabel: UILabel!
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    override func setupView() {
        super.setupView()
        setupScrollableStackView()
        setupPosterImageView()
        setupNameLabel()
        setupOverviewLabel()
        setupFirstAirDateLabel()
        setupRatingLabel()
        setupLabelStackView()
    }
    
    override func bindViewModel() {
        let movieDetailSubject = BehaviorRelay<MovieDetailModel>(value: MovieDetailModel())
        let output = viewModel.transform(input: MovieDetailViewModel.Input(movieDetailSubject: movieDetailSubject))
        output.movieDetailObservable
            .subscribe { [weak self] movie in
                guard let self = self else { return }
                self.posterImageView.sd_setImage(with: URL(string: movie.posterPath ?? "UndefinedText".localized))
                let nameText = "MovieNameTitle".localized + (movie.name ?? "UndefinedText".localized)
                self.nameLabel.text = nameText
                let overviewText = "MovieOverviewTitle".localized + (movie.overview ?? "UndefinedText".localized)
                self.overviewLabel.text = overviewText
                let firstAirDateText = "MovieFirstAirDateTitle".localized + (movie.firstAirDate ?? "UndefinedText".localized)
                self.firstAirDateLabel.text = firstAirDateText
                let ratingText = "MovieRatingTitle".localized + "\(movie.rating ?? 0)"
                self.ratingLabel.text = ratingText
            }
            .disposed(by: disposeBag)
    }
    
    private func setupScrollableStackView() {
        scrollableStackView = ScrollableStackView(frame: .zero, itemSpacing: 20)
        view.addSubview(scrollableStackView)
        scrollableStackView.snp.makeConstraints { view in
            view.top.left.equalToSuperview().offset(20)
            view.right.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupPosterImageView() {
        posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        scrollableStackView.addViewToStackView(posterImageView)
        posterImageView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.height.equalTo(250)
        }
    }
    
    private func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = .zero
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
    }

    private func setupOverviewLabel() {
        overviewLabel = UILabel()
        overviewLabel.font = UIFont.systemFont(ofSize: 16)
        overviewLabel.textColor = .black
        overviewLabel.numberOfLines = .zero
        overviewLabel.textColor = .black
        overviewLabel.textAlignment = .center
    }

    private func setupFirstAirDateLabel() {
        firstAirDateLabel = UILabel()
        firstAirDateLabel.font = UIFont.systemFont(ofSize: 16)
        firstAirDateLabel.textColor = .black
        firstAirDateLabel.numberOfLines = .zero
        firstAirDateLabel.textColor = .black
        firstAirDateLabel.textAlignment = .center
    }

    private func setupRatingLabel() {
        ratingLabel = UILabel()
        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        ratingLabel.textColor = .black
        ratingLabel.numberOfLines = .zero
        ratingLabel.textColor = .black
        ratingLabel.textAlignment = .center
    }
    
    private func setupLabelStackView() {
        labelStackView = UIStackView(arrangedSubviews: [nameLabel, overviewLabel, firstAirDateLabel, ratingLabel])
        labelStackView.spacing = 20
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.alignment = .fill
        labelStackView.distribution = .fill
        scrollableStackView.addViewToStackView(labelStackView)
    }
}
