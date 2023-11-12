//
//  StringExtensions.swift
//  PopularMovies
//
//  Created by Cem Kazım on 11.11.2023.
//

import UIKit

extension String {
    
    var localized: String {
        NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func convertStringToDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? nil
    }
}
