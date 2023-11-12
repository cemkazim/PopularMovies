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
        setupView()
        bindData()
    }
    
    // MARK: - Methods
    
    /// Description: Perform all view setup operations.
    func setupView() {
        view.backgroundColor = .white
    }
    
    /// Description: Bind view model data after the view is created.
    func bindData() {}
}
