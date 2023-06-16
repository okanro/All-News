//
//  ArticleCellViewModel.swift
//  AllNews
//
//  Created by Okan Özdemir on 16.06.2023.
//

import Foundation

class ArticleCellViewModel: ObservableObject {
    /// Date form changer for see only hours and minutes
    /// - Parameter dateString: date format which sets "yyyy-MM-dd'T'HH:mm:ssZ"
    /// - Returns: date format in "HH:mm:ss"
    func formatDate(_ dateString: String?) -> String {
        guard let dateString = dateString else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date ?? Date())
    }
}
