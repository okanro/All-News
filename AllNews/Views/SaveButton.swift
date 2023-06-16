//
//  SaveButton.swift
//  AllNews
//
//  Created by Okan Özdemir on 16.06.2023.
//

import Foundation
import SwiftUI

struct SaveButton: View {
    let article: Article
    @State private var saveManager = SavedArticlesManager()
    @Binding var isSaved: Bool
    @ObservedObject var vm = ArticleCellViewModel()

    var body: some View {
        Button {
            if saveManager.savedArticles.contains(where: { $0.title == article.title }) {
                removeArticle(article)
            } else {
                saveArticle(article)
            }
        } label: {
            Text(isSaved == true ? "Okuma listesinden çıkar" : "Okuma listesine ekle")
        }
    }
}

extension SaveButton {
    // MARK: - Functions

    func saveArticle(_ article: Article) {
        var savedArticles = saveManager.savedArticles
        savedArticles.append(article)
        saveManager.savedArticles = savedArticles
        isSaved = true
        print(savedArticles)
    }

    func removeArticle(_ article: Article) {
        var savedArticles = saveManager.savedArticles
        if let index = savedArticles.firstIndex(where: { $0.title == article.title }) {
            savedArticles.remove(at: index)
            saveManager.savedArticles = savedArticles
            print(savedArticles)
            isSaved = false
        }
    }
}
