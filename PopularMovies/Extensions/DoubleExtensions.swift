//
//  DoubleExtensions.swift
//  PopularMovies
//
//  Created by Cem Kazım on 12.11.2023.
//

import Foundation

extension Double {
    
    var handleSmallScreen: Double {
        if isSmallScreen {
            let ratio = self / 812
            return Double(screenHeight) * ratio
        } else {
            return self
        }
    }
}
