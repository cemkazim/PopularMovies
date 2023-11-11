//
//  BaseViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: T
    
    // MARK: - Initializers
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        bindViewModel()
    }
    
    // MARK: - Methods
    
    func setupView() {}
    
    func bindViewModel() {}
}
