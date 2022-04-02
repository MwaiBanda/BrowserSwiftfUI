//
//  Bookmark.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import Foundation

// MARK: - Welcome
struct Bookmark: Codable, Hashable {
    let metadata: Metadata
    let socials: Socials?
    let favicons: [String]
}

// MARK: - Metadata
struct Metadata: Codable,Hashable {
    let website: String
    let title, metadataDescription: String?
    let banner: String?
    let themeColor: String?

    enum CodingKeys: String, CodingKey {
        case website, title
        case metadataDescription = "description"
        case banner, themeColor
    }
}

// MARK: - Socials
struct Socials: Codable, Hashable {
    let twitterSite, twitterCreator: String?

      enum CodingKeys: String, CodingKey {
          case twitterSite = "twitter:site"
          case twitterCreator = "twitter:creator"
      }
}
