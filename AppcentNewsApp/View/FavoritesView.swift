//
//  FavoritesView.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 8.05.2024.
//

import UIKit

class FavoritesView: UIView {
    
    //MARK: - Private Variables/Components
    private var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        return tableView
        
    }()
    
    //MARK: - Getter
    public var getTableView : UITableView {
        return tableView
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
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}

// Önizleme
#Preview(""){
    FavoritesView()
}
