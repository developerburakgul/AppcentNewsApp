//
//  NewsDetailVC.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 8.05.2024.
//

import UIKit

class NewsDetailVC: UIViewController {
    var article: Article
    private var favoritesManager: FavoritesManaging
    init(article: Article,favoritesManager : FavoritesManaging) {
        self.article = article
        self.favoritesManager = favoritesManager
        super.init(nibName: nil, bundle: nil)
    }
    
    // NSCoder ile başlatma desteklenmiyor.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // View yüklendiğinde ek kurulum yapılabilir.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        let newsView = NewsDetailView()
        newsView.configure(with: article)
        newsView.getSourceButton.addTarget(self, action: #selector(goToNewsSource), for: .touchUpInside)
        setupNavigationBar()
        
        self.view = newsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    
    
    
    
    
    
    @objc func goToNewsSource() {
        let newsSourceVC = NewsSourceVC(urlString: article.url)
        newsSourceVC.hidesBottomBarWhenPushed = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(newsSourceVC, animated: true)
    }
    
    
    
    private func setupNavigationBar() {
//        self.navigationItem.title = "News Detail" // there is no title for this screen so i didnt add title ,
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.systemBackground
            appearance.titleTextAttributes = [.foregroundColor: UIColor.label,.font : UIFont.boldSystemFont(ofSize: 25)]  // Başlık metin rengi
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            // iOS 15 altı için eski yöntemler
            navigationController?.navigationBar.barTintColor = .systemBackground
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
        }
        setupNavigationBarButtons()
    }
    
    private func setupNavigationBarButtons() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: favoritesManager.isItFavorites(article: article) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")  ,
                style: .done,
                target: self,
                action: #selector(addFavorites)
            ),
            UIBarButtonItem(
                image: UIImage(systemName: "square.and.arrow.up"),
                style: .done,
                target: self,
                action: #selector(share)
            )
            
        ]
        navigationController?.navigationBar.tintColor = CustomColor.buttonBackgroundColor
        
    }
    
    @objc func addFavorites() {
        if !favoritesManager.isItFavorites(article: article){
            navigationItem.rightBarButtonItems?[0].image = UIImage(systemName: "heart.fill")
            favoritesManager.addFavorite(article: article)
        }else {
            navigationItem.rightBarButtonItems?[0].image = UIImage(systemName: "heart")
            favoritesManager.removeFavorite(article: article)
        }
        
        
    }
    
    
    @objc func share() {
        let itemsToShare: [Any] = [article.title, article.url].compactMap { $0 }
        
        let activityViewController = UIActivityViewController(
            activityItems: itemsToShare,
            applicationActivities: nil
        )
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            // This needs to be adjusted if you want the popover to appear in a specific location
            popoverController.sourceRect = CGRect(
                x: self.view.bounds.midX,
                y: self.view.bounds.midY,
                width: 0,
                height: 0
            )
            popoverController.permittedArrowDirections = []
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    
}

#Preview(""){
    
    
    UINavigationController(rootViewController:NewsDetailVC(article: Article(source: Source(id: "1", name: "bura"), author: nil, title: "title", description: "description", url: "https://avatars.githubusercontent.com/u/111520412?v=4", urlToImage: "https://avatars.githubusercontent.com/u/111520412?v=4", publishedAt: "2024-04-15T19:26:21Z", content: "uuu"), favoritesManager: FavoritesManager()) )}
