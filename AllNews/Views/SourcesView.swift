//
//  SourcesView.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import Foundation
import SwiftUI

struct SourcesView: View {
    @StateObject var viewModel = SourcesViewModel()
    private var navigationTitleString = "Sources"

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        allCategoryButtonsView
                    }
                    .padding(.horizontal, 8)
                }
                sourcesView
            }
            .navigationTitle(navigationTitleString)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if viewModel.sources.isEmpty {
                    viewModel.getSources()
                }
            }
        }
    }
}

struct SourceViewPreview_Previews: PreviewProvider {
    static var previews: some View {
        SourcesView()
    }
}

extension SourcesView {
    private var allCategoryButtonsView: some View {
        ForEach(viewModel.categories, id: \.self) { category in
            Button(action: {
                viewModel.toggleCategory(category)
            }) {
                HStack {
                    Image(systemName: viewModel.selectedCategories.contains(category) ? "checkmark" : "plus")
                        .tint(.blue)
                    Text(category)
                        .foregroundColor(viewModel.selectedCategories.contains(category) ? .white : .primary)
                        .padding(8)
                }
                .padding(.horizontal, 5)
                .background(viewModel.selectedCategories.contains(category) ? Color.purple.opacity(0.6) : Color.gray.opacity(0.2))
                .cornerRadius(4)
            }
        }
    }

    private var sourcesView: some View {
        List {
            ForEach(viewModel.sources.sorted { $0.name < $1.name }) { source in
                VStack(alignment: .leading, spacing: 5) {
                    NavigationLink(destination: ArticlesView(source: source)) {
                        Text(source.name)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.leading)
                    }
                    Text(source.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .listStyle(.plain)
        .id(UUID())
    }
}
