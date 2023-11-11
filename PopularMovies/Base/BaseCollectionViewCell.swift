//
//  BaseCollectionViewCell.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var cellID: String {
        String(describing: self)
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
