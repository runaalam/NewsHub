//
//  WebView.swift
//  NewsHub
//
//  Created by Runa Alam on 18/7/2023.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

//struct WebView: UIViewControllerRepresentable {
//    let urlString: String
//
//    func makeUIViewController(context: Context) -> WKWebViewViewController {
//        let webView = WKWebViewViewController()
//        return webView
//    }
//
//    func updateUIViewController(_ uiViewController: WKWebViewViewController, context: Context) {
//        if let url = URL(string: urlString) {
//            let request = URLRequest(url: url)
//            uiViewController.load(request)
//        }
//    }
//}
//
//class WKWebViewViewController: UIViewController, WKNavigationDelegate {
//    private var webView: WKWebView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupWebView()
//    }
//
//    private func setupWebView() {
//        webView = WKWebView(frame: view.frame)
//        webView.navigationDelegate = self
//        view.addSubview(webView)
//    }
//
//    func load(_ request: URLRequest) {
//        webView.load(request)
//    }
//
//    // Implement WKNavigationDelegate methods if needed
//}
