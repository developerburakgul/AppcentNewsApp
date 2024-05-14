//
//  FavoritesManager.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 12.05.2024.
//

import Foundation

//MARK: - Protocol
protocol FavoritesManaging {
    func addFavorite(article: Article)
    func removeFavorite(article: Article)
    func getFavorites() -> [Article]
    func isItFavorites(article:Article) -> Bool
}

//MARK: - Class

class FavoritesManager: FavoritesManaging {
    //MARK: - Private Variables
    private let defaults: UserDefaults
    private let favoritesKey = "favorites"
    private var favorites: [Favorite] = []
    
    //MARK: - İnitializer
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        loadFavorites()
    }
    
    //MARK: - Public Functions
    
    func addFavorite(article: Article) {
        let newFavorite = Favorite(article: article)
        if !isItFavorites(article: article) {
            favorites.append(newFavorite)
            saveFavorites()
        }
    }
    
    func removeFavorite(article: Article) {
        favorites.removeAll { $0.article.url == article.url }
        saveFavorites()
        
    }
    
    func getFavorites() -> [Article] {
        return favorites.map { $0.article }.reversed()
    }
    
    func isItFavorites(article : Article) -> Bool {
        return favorites.contains { $0.article.url == article.url }
    }
    
    //MARK: - Private Functions
    
    private func saveFavorites() {
        do {
            let encoded = try JSONEncoder().encode(favorites)
            defaults.set(encoded, forKey: favoritesKey)
        } catch {
            print("Hata: Favoriler kaydedilirken bir sorun oluştu: \(error)")
        }
    }
    
    private func loadFavorites() {
        guard let data = defaults.data(forKey: favoritesKey) else { return }
        do {
            favorites = try JSONDecoder().decode([Favorite].self, from: data)
        } catch {
            print("Hata: Favoriler yüklenirken bir sorun oluştu: \(error)")
        }
    }
    
}



