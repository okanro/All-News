//
//  Article.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import Foundation

/// Model for articles
struct Article: Codable {
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
}
