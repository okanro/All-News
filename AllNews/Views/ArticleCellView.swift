//
//  ArticleCellView.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import SwiftUI

struct ArticleCellView: View {
    @StateObject var vm = ArticleCellViewModel()
    @State private var isSaved: Bool = false
    let article: Article
    let noImageAvaibleURL: String = "https://i.hizliresim.com/fvlu1vx.png"
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: article.urlToImage ?? noImageAvaibleURL)!) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: { ProgressView() }

            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                HStack {
                    SaveButton(article: article, isSaved: $isSaved)
                    Spacer()
                    Text(vm.formatDate(article.publishedAt))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxHeight: 100)
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct ArticleCellView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCellView(article: Article(
            title: "Mt. Gox: all the news on Bitcoin’s original biggest bankruptcy scandal",
            description: "One of the strangest stories in crypto still isn’t over. Mt. Gox went bankrupt in 2014 after losing track of more than 650,000 Bitcoins through theft or mismanagement and its CEO was arrested. But the story didn’t end there.",
            url: "https://www.theverge.com/2014/3/21/5533272/mt-gox-missing-bitcoins",
            urlToImage: "https://cdn.vox-cdn.com/thumbor/cT46bayUXzTSLryuplguioQYo78=/0x0:560x372/1200x628/filters:focal(280x186:281x187)/cdn.vox-cdn.com/uploads/chorus_asset/file/10987061/mt-gox-hq.0.0.jpg",
            publishedAt: "2023-06-09T17:28:51Z"))
    }
}
