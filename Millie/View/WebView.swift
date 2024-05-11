//
//  WebView.swift
//  Millie
//
//  Created by 김기남 on 2024/05/08.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var urlString: String
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        
        if let url = URL(string: self.urlString) {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
