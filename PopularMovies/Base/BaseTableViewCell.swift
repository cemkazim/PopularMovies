//
//  BaseTableViewCell.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var cellID: String {
        String(describing: self)
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /// Description: Perform all view setup operations.
    func setupView() {}
}
