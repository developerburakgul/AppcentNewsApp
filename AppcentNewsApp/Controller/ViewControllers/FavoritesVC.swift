//
//  FavoritesVC.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 8.05.2024.
//

import UIKit

class FavoritesVC: UIViewController {
    
    private var favoritesManager: FavoritesManaging
    private var favorites: [Article] = []
    
    init(favoritesManager: FavoritesManaging) {
        self.favoritesManager = favoritesManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let favoritesView = FavoritesView()
        let tableView = favoritesView.getTableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        setupNavigationBar()
        
        self.view = favoritesView
        loadFavorites()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        print("viewWillAppear çalıştı")
        loadFavorites()
        print("viewWillappaer bitcek")
    }
  
    private func loadFavorites() {
        print("loadFavorites() called")
        favorites = favoritesManager.getFavorites()
        print("favoriler yüklendi : \(favorites)")
        
                if let favoritesView = self.view as? FavoritesView {
                    favoritesView.getTableView.reloadData()
                }
            
       
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Favorites"
        
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.systemBackground  // Navigation bar arka plan rengi
            appearance.titleTextAttributes = [.foregroundColor: UIColor.label,.font : UIFont.boldSystemFont(ofSize: 25)]  // Başlık metin rengi
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            // iOS 15 altı için eski yöntemler
            navigationController?.navigationBar.barTintColor = .systemBackground
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
        }
    }
}


//MARK: - TableView Data Source
extension FavoritesVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell {
            let data = favorites[indexPath.row]
            cell.configure(with: data.title, description: data.description, imageURL: data.urlToImage)
            return cell
        }else {
            let cell = UITableViewCell()
            cell.backgroundColor = .red
            print("girmediiiii")
            return cell
        }
        
    }
}


//MARK: - TableView Delegate
extension FavoritesVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = favorites[indexPath.row]
        
        let newViewController = NewsDetailVC(article:article, favoritesManager: FavoritesManager() )
//        newViewController.setupNavigationBar()
        newViewController.hidesBottomBarWhenPushed = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            // Silme işlemi için bir swipe action oluştur
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") {  (action, view, completionHandler) in
                // Silme işlemini burada gerçekleştir
                let articleData = self.favorites[indexPath.row]
                self.favoritesManager.removeFavorite(article: articleData)
                self.loadFavorites()
                completionHandler(true)
            }
            
            // Sola kaydırma işleminin yapılandırmasını döndür
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    
}


