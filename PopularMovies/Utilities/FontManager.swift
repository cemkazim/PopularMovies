//
//  FontManager.swift
//  PopularMovies
//
//  Created by Cem Kazım on 12.11.2023.
//

import UIKit

class FontManager {
    
    /// Description: You can get SFProRounded font from this method.
    static func roundedFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        let font: UIFont
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: fontSize)
        } else {
            font = systemFont
        }
        return font
    }
}
