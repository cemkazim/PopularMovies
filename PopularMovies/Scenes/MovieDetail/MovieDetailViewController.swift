//
//  MovieDetailViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class MovieDetailViewController: BaseViewController<MovieDetailViewModel> {
    
    // MARK: - Properties
    
    private var scrollableStackView: ScrollableStackView!
    private var labelStackView: UIStackView!
    private var posterImageView: UIImageView!
    private var overviewLabel = CommonLabel(style: .normal)
    private var firstAirDateLabel = CommonLabel(style: .content)
    private var ratingLabel = CommonLabel(style: .content)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    override func setupView() {
        super.setupView()
        setupScrollableStackView()
        setupPosterImageView()
        setupLabelStackView()
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel else { return }
        posterImageView.sd_setImage(with: URL(string: viewModel.getMovie().posterPath ?? ""))
        navigationItem.title = viewModel.getMovie().name ?? ""
        overviewLabel.text = viewModel.getMovie().overview ?? ""
        if let firstAirDate = (viewModel.getMovie().firstAirDate ?? "").convertStringToDate(format: serverDateFormat) {
            let dateString = firstAirDate.convertDateToString(format: localizeDateFormat)
            firstAirDateLabel.text = "MovieFirstAirDateTitle".localized + dateString
        } else {
            firstAirDateLabel.text = "MovieFirstAirDateTitle".localized + "Undefined".localized
        }
        ratingLabel.text = "MovieRatingTitle".localized + "\(viewModel.getMovie().rating ?? 0)" + "/10"
    }
    
    private func setupScrollableStackView() {
        scrollableStackView = ScrollableStackView(frame: .zero, itemSpacing: 20)
        mainView.addSubview(scrollableStackView)
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
            view.height.equalTo(400.handleSmallScreen)
        }
    }
    
    private func setupLabelStackView() {
        labelStackView = UIStackView(arrangedSubviews: [overviewLabel, firstAirDateLabel, ratingLabel])
        labelStackView.spacing = 20
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.alignment = .fill
        labelStackView.distribution = .fill
        scrollableStackView.addViewToStackView(labelStackView)
    }
}
