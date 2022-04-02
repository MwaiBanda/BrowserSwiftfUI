//
//  BrowserSwiftUIApp.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import SwiftUI

@main
struct BrowserSwiftUIApp: App {
    @StateObject private var networkService = NetworkService.sharedInstance

    var body: some Scene {
        WindowGroup {
            ContentView(networkService: networkService)
        }
    }
}
