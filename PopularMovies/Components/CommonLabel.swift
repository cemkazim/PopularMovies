//
//  CommonLabel.swift
//  PopularMovies
//
//  Created by Cem Kazım on 12.11.2023.
//

import UIKit

class CommonLabel: UILabel {
    
    enum LabelStyle {
        case title
        case normal
        case content
    }
    
    init(frame: CGRect = .zero, style: LabelStyle) {
        super.init(frame: frame)
        switch style {
        case .title:
            font = FontManager.roundedFont(ofSize: 20, weight: .bold)
            textColor = .black
            numberOfLines = .zero
            textAlignment = .center
        case .normal:
            font = FontManager.roundedFont(ofSize: 16, weight: .medium)
            textColor = .black
            numberOfLines = .zero
            textAlignment = .left
        case .content:
            font = FontManager.roundedFont(ofSize: 16, weight: .semibold)
            textColor = .black
            numberOfLines = .zero
            textAlignment = .left
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
