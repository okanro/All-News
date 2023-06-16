//
//  ArticlesView.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import SwiftUI

struct ArticlesView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var viewModel: ArticlesViewModel
    @State private var currentIndex = 0
    @State private var tabViewTimer: Timer?
    @State private var getSourceTimer: Timer?
    let source: Source

    init(source: Source) {
        self.source = source
        self.viewModel = ArticlesViewModel(source: source)
    }

    // Body View
    var body: some View {
        ScrollView {
            VStack {
                topThreeArticleView
                otherArticlesView
            }
            .padding(.horizontal, 4)
        }
        .navigationTitle(source.name)
        .onAppear {
            viewModel.getArticles()
        }
    }
}

extension ArticlesView {
    // MARK: - Helper Views

    private var topThreeArticleView: some View {
        TabView(selection: $currentIndex) {
            ForEach(viewModel.topArticles.indices, id: \.self) { index in
                ArticleCellView(article: viewModel.topArticles[index])
                    .tag(index)
            }
        }
        .frame(height: 380)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 15)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onAppear {
            setupAppearance()
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    private var otherArticlesView: some View {
        ForEach(viewModel.otherArticles, id: \.title) { article in
            Divider()
            ArticleCellView(article: article)
        }
    }

    // MARK: - Functions

    /// Tab view's dot indicator's color
    private func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .darkGray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemBlue.withAlphaComponent(0.8)
    }

    /// Start timer for change tabviews tabs every 5 second and update articles every 1 minute
    private func startTimer() {
        tabViewTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            withAnimation {
                self.currentIndex = (self.currentIndex + 1) % self.viewModel.topArticles.count
                print(timer)
            }
        }
        getSourceTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            viewModel.getArticles()
        }
    }

    private func stopTimer() {
        tabViewTimer?.invalidate()
        tabViewTimer = nil

        getSourceTimer?.invalidate()
        getSourceTimer = nil
    }
}
