//
//  WebViewController.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 29/03/2024.
//

import Foundation
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    let url: URL

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
}
