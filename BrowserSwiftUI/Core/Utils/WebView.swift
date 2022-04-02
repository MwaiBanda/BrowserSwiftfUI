//
//  WebView.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//


import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
 
    var url: URL
    let webView: WKWebView
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
