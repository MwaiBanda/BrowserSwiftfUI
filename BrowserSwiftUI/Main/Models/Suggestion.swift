//
//  Suggestion.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import Foundation

struct Suggestion: Hashable {
    var id = UUID().uuidString
    var imageURL: String
    var webURL: String
}

var suggestions = [
    Suggestion(imageURL: "https://tinyurl.com/google-png", webURL: "https://www.google.com"),
    Suggestion(imageURL: "https://www.freepnglogos.com/uploads/yahoo-logo-png/yahoo-logo-png-free-download-3.png", webURL: "https://www.yahoo.com"),
    Suggestion(imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/YouTube_Logo_%282013-2017%29.svg/2560px-YouTube_Logo_%282013-2017%29.svg.png", webURL: "https://www.youtube.com"),
    Suggestion(imageURL: "https://logos-world.net/wp-content/uploads/2020/11/GitHub-Logo.png", webURL: "https://www.github.com/MwaiBanda"),
    Suggestion(imageURL: "https://assets.stickpng.com/images/580b57fcd9996e24bc43c521.png", webURL: "https://www.instagram.com"),
    Suggestion(imageURL: "https://assets.stickpng.com/images/580b57fcd9996e24bc43c53e.png", webURL: "https://www.twitter.com"),

]
