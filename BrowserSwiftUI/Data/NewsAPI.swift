//
//  NewsAPI.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import Foundation

class NewsAPI: ObservableObject {
    func getArticles(completion: @escaping (Result<[Article], Error>) -> ()) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6f50cf66a4df4d59b0652254b941263d")!
        let request  = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            DispatchQueue.main.async {
                print(data!)
                do {
                let shows = try JSONDecoder().decode(Articles.self, from: data!)
                    completion(.success(shows.articles))
                } catch DecodingError.dataCorrupted(let context) {
                    print(context)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }
        task.resume()
    }
}
