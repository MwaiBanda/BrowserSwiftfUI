//
//  Article.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import Foundation


// MARK: - Articles
struct Articles: Codable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    var title, articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

extension Article: Identifiable {
    
    var id: String {
        return UUID().uuidString
    }
    
   
}
