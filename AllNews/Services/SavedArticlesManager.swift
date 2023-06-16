//
//  SavedArticlesManager.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import Foundation

class SavedArticlesManager {
    static let shared = SavedArticlesManager()

    let savedArticlesKey = "savedArticles"
    let defaults = UserDefaults.standard

    var savedArticles: [Article] {
        get {
            if let data = defaults.data(forKey: savedArticlesKey) {
                if let articles = try? JSONDecoder().decode([Article].self, from: data) {
                    return articles
                }
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                defaults.set(data, forKey: savedArticlesKey)
            }
        }
    }
}
