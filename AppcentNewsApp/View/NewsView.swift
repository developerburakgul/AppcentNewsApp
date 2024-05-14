//
//  NewsView.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 8.05.2024.
//

import UIKit

class NewsView: UIView {
    
    //MARK: - Private Variables/Components
    private var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Type a text"
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.systemGray3
            textfield.layer.cornerRadius = 15
            textfield.clipsToBounds = true
        }
        
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        searchBar.layer.shadowRadius = 4.0
        searchBar.layer.shadowOpacity = 0.4
        searchBar.layer.masksToBounds = false
        searchBar.backgroundColor = .systemBackground
        return searchBar
    }()
    
    private var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        return tableView
        
    }()
    
    private var tapGesture : UITapGestureRecognizer = {
        let tapGesture  = UITapGestureRecognizer()
        return tapGesture
    }()
    
    private let noDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = false
        
        return imageView
    }()
    
    //MARK: - Public Variables/Getters
    public var getTableView : UITableView {
        return tableView
    }
    
    public var getSearchBar : UISearchBar {
        return searchBar
    }
    
    public var getTapGesture : UITapGestureRecognizer {
        return tapGesture
    }
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Setup Functions
    
    private func setup() {
        setupSearchBar()
        setupTableView()
        setupNoDataImageView()
        updateNoDataImage()
    }
    
    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    private func setupNoDataImageView() {
        addSubview(noDataImageView)
        noDataImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noDataImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noDataImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noDataImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            noDataImageView.heightAnchor.constraint(equalTo: self.widthAnchor),
            
        ])
        
    }
    
    
    //MARK: - Private Functions
    private  func updateNoDataImage() {
        if traitCollection.userInterfaceStyle == .dark {
            noDataImageView.image = UIImage(named: "logo-white")
        } else {
            noDataImageView.image = UIImage(named: "logo-black")
        }
    }
    
    //MARK: - Public Functions
    
    func showNoDataImageView() {
        noDataImageView.isHidden = false
    }
    
    func hideNoDataImageView() {
        noDataImageView.isHidden = true
    }
    
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateNoDataImage()
        }
    }
    
}


