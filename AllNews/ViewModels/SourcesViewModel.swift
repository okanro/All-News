//
//  SourcesViewModel.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import Foundation

class SourcesViewModel: ObservableObject {
    @Published var sources = [Source]()
    @Published var categories = SourceCategories().categories
    @Published var toggleCategory: Bool = false
    @Published var selectedCategories: [String] = []
    @Published var topArticles: [Article] = []
    @Published var otherArticles: [Article] = []

    let networkManager = NetworkManager()

    /// Toggles category with only sources about category/categories
    /// - Parameter category: selected category when pressed button
    func toggleCategory(_ category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.removeAll { $0 == category }
            if selectedCategories.isEmpty {
                getSources()
            }
        } else {
            selectedCategories.append(category)
        }
        sources = []
        selectedCategories.forEach { str in
            let categoryURLs = "&category=" + str
            networkManager.getSources(categoryURL: categoryURLs) { [weak self] sources in
                DispatchQueue.main.async {
                    self?.sources.append(contentsOf: sources)
                }
            }
        }
    }

    func getSources(categoryURL: String = "") {
        networkManager.getSources(categoryURL: categoryURL) { [weak self] sources in
            DispatchQueue.main.async {
                self?.sources = sources
            }
        }
    }
}
