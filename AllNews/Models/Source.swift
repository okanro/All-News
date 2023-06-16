//
//  Sources.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import Foundation

/// Model for source endpoint
struct Source: Codable, Identifiable {
    var id: String
    var name: String
    var description: String
    var url: String
    var category: String
}
