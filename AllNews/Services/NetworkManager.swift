//
//  NetworkManager.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import Foundation

class NetworkManager {
    let apiKey = SecretKeys().apiKey
    let baseUrl = "https://newsapi.org"

    func getSources(categoryURL: String = "", completion: @escaping ([Source]) -> ()) {
        let url = "\(baseUrl)/v2/sources?language=en" + categoryURL + "&apiKey=\(apiKey)"
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching sources: \(error)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("Error fetching sources: no data")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let sourcesResponse = try decoder.decode(SourcesResponse.self, from: data)
                let sources = sourcesResponse.sources
                print(url)
                completion(sources)
            } catch {
                print("Error decoding sources: \(error)")
                completion([])
            }
        }.resume()
    }
    
    func getArticles(for source: Source, completion: @escaping ([Article]) -> ()) {
        let url = "\(baseUrl)/v2/top-headlines?sources=\(source.id)&apiKey=\(apiKey)"
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching articles: \(error)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("Error fetching articles: no data")
                completion([])
                return
            }
            
            do {
                print(url)
                let decoder = JSONDecoder()
                let articlesResponse = try decoder.decode(ArticlesResponse.self, from: data)
                let articles = articlesResponse.articles
                completion(articles)
            } catch {
                print("Error decoding articles: \(error)")
                completion([])
            }
        }.resume()
    }
}
