//
//  SearchViewModel.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import UIKit
import WebKit

final class SearchViewModel: ObservableObject {
    internal init(webView: WKWebView = WKWebView()) {
        self.webView = webView
        setupBindings()
    }
    
    let webView: WKWebView
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    
    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        
        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
    }
    
    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }
}
