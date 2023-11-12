//
//  DynamicTableView.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit

class DynamicTableView: UITableView {
    
    // MARK: - Properties
    
    public override var intrinsicContentSize: CGSize { contentSize }
    
    // MARK: - Methods
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !bounds.size.equalTo(intrinsicContentSize) {
            invalidateIntrinsicContentSize()
        }
    }
}
