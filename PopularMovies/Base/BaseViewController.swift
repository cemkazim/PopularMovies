//
//  BaseViewController.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SnapKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: T?
    var mainView: UIView!
    
    // MARK: - Initializers
    
    init(viewModel: T? = nil) {
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
        bindViewModel()
    }
    
    // MARK: - Methods
    
    /// Description: Perform all view setup operations.
    func setupView() {
        mainView = UIView()
        mainView.backgroundColor = .white
        view.addSubview(mainView)
        mainView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
    }
    
    /// Description: Bind view model data after the view is created.
    func bindViewModel() {}
}
