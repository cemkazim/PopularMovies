//
//  MovieDetailViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class MovieDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var scrollableStackView: ScrollableStackView!
    private var labelStackView: UIStackView!
    private var posterImageView: UIImageView!
    private var nameLabel: UILabel!
    private var overviewLabel: UILabel!
    private var firstAirDateLabel: UILabel!
    private var ratingLabel: UILabel!
    private var viewModel: MovieDetailViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods
    
    func setupViewModel(_ viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupView() {
        scrollableStackView = ScrollableStackView(frame: .zero, itemSpacing: 20)
        view.addSubview(scrollableStackView)
        posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        posterImageView.sd_setImage(with: URL(string: viewModel.movie.posterPath ?? ""))
        scrollableStackView.addViewToStackView(posterImageView)
        nameLabel = UILabel()
        create(label: nameLabel,
               text: "Name: \(viewModel.movie.name ?? "")",
               font: UIFont.systemFont(ofSize: 16),
               alignment: .center)
        overviewLabel = UILabel()
        create(label: overviewLabel,
               text: "Overview:\n \(viewModel.movie.overview ?? "")",
               font: UIFont.systemFont(ofSize: 16),
               alignment: .center)
        firstAirDateLabel = UILabel()
        create(label: firstAirDateLabel,
               text: "First Air Date: \(viewModel.movie.firstAirDate ?? "")",
               font: UIFont.systemFont(ofSize: 16),
               alignment: .center)
        ratingLabel = UILabel()
        create(label: ratingLabel,
               text: "Rating: \(viewModel.movie.rating ?? 0)",
               font: UIFont.systemFont(ofSize: 16),
               alignment: .center)
        labelStackView = UIStackView(arrangedSubviews: [nameLabel, overviewLabel, firstAirDateLabel, ratingLabel])
        labelStackView.spacing = 20
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.alignment = .fill
        labelStackView.distribution = .fill
        scrollableStackView.addViewToStackView(labelStackView)
        scrollableStackView.snp.makeConstraints { view in
            view.top.left.equalToSuperview().offset(20)
            view.right.bottom.equalToSuperview().offset(-20)
        }
        posterImageView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.height.equalTo(250)
        }
    }
    
    private func create(label: UILabel, text: String, font: UIFont, alignment: NSTextAlignment) {
        label.text = text
        label.font = font
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = alignment
    }
}
