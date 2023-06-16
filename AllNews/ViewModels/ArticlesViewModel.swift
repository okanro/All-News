//
//  ArticlesViewModel.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import Foundation
import SwiftUI

class ArticlesViewModel: ObservableObject {
    let source: Source
    @Published var articles = [Article]()
    @Published var topArticles: [Article] = []
    @Published var otherArticles: [Article] = []
    let networkManager = NetworkManager()
    let saveManager = SavedArticlesManager()

    init(source: Source) {
        self.source = source
    }

    func getArticles() {
        networkManager.getArticles(for: source) { articles in
            let topArticles = Array(articles.prefix(3))
            let otherArticles = Array(articles.dropFirst(3))
            DispatchQueue.main.async {
                self.topArticles = topArticles
                self.otherArticles = otherArticles
                self.articles = articles
            }
        }
    }
}
