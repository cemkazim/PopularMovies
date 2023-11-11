//
//  MovieDetailViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
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
        
    }
}
