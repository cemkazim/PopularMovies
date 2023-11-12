//
//  ScrollableStackView.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit
import SnapKit

class ScrollableStackView: UIView {
    
    // MARK: - Properties
    
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    private var itemSpacing: CGFloat = 0
    
    // MARK: - Lifecycle
    
    init(frame: CGRect, itemSpacing: CGFloat) {
        super.init(frame: frame)
        self.itemSpacing = itemSpacing
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = itemSpacing
        scrollView.addSubview(stackView)
        scrollView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
            view.width.equalToSuperview()
        }
    }
    
    /// Description: Add an arranged subview to StackView.
    /// - Parameters:
    ///   - subview: Any UIView item.
    public func addViewToStackView(_ subview: UIView) {
        stackView.addArrangedSubview(subview)
    }
}
