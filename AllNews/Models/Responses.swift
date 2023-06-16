//
//  Responses.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import Foundation

struct SourcesResponse: Decodable {
    let status: String
    let sources: [Source]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case sources
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        sources = try container.decode([Source].self, forKey: .sources)
    }
}
struct ArticlesResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
