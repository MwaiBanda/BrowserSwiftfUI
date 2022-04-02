//
//  MetadataAPI.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import Foundation

class MetadataAPI: ObservableObject {
    func getUrlMetadata(url: String, completion: @escaping (Result<Bookmark, Error>) -> ()) {
        let url = URL(string: "https://virtualgroceries.glitch.me/meta/?url=\(url)")!
        let request  = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            DispatchQueue.main.async {
                print(data!)
                do {
                let bookmark = try JSONDecoder().decode(Bookmark.self, from: data!)
                    completion(.success(bookmark))
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
