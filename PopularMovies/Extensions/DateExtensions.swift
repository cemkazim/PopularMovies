//
//  DateExtensions.swift
//  PopularMovies
//
//  Created by Cem Kazım on 12.11.2023.
//

import Foundation

extension Date {
    
    func convertDateToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
