//
//  ContentView.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkService: NetworkService

    var body: some View {
        ConnectivityWrapper(networkService: networkService) {
            TabBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(networkService: NetworkService.sharedInstance)
    }
}
