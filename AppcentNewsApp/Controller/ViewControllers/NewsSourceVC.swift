//
//  NewsSourceVC.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 12.05.2024.
//

import UIKit
import WebKit


class NewsSourceVC: UIViewController, WKUIDelegate {
    
    var webView: WKWebView = {
        
        let webConfiguration = WKWebViewConfiguration()
        var webView  = WKWebView(frame: .zero, configuration: webConfiguration)
        return webView
    }()
    var urlString : String
    var activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
    }()
    
    init(urlString: String) {
           self.urlString = urlString
           super.init(nibName: nil, bundle: nil)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self // Bu satır önemli

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        setup()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setup()  {
        setupWebView()
        setupActivityIndicator()
        setupNavigationBar()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            activityIndicator.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "News Source"
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            appearance.titleTextAttributes = [.foregroundColor: UIColor.label, .font: UIFont.boldSystemFont(ofSize: 25)]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.barTintColor = .systemBackground
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
        }

    }
}


extension NewsSourceVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

#Preview(""){

    UINavigationController(rootViewController: NewsSourceVC(urlString: "https://github.com/developerburakgul"))
}
