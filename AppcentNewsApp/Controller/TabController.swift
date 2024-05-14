import UIKit

class TabController: UITabBarController {
    
    private let favoritesManager: FavoritesManager
    private let newsService: NewsService

    // Initializer
    init(favoritesManager: FavoritesManager, newsService: NewsService) {
        self.favoritesManager = favoritesManager
        self.newsService = newsService
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Private Setup Functions
    private func setup() {
        setupTabs()
        setupTabbarAppearance()
    }
    
    private func setupTabs() {
        let newsVC = NewsVC(newsService: newsService, favoritesManager: favoritesManager)
        let favoritesVC = FavoritesVC(favoritesManager: favoritesManager)
        let controllers = [newsVC, favoritesVC].map { UINavigationController(rootViewController: $0) }
        self.viewControllers = controllers
        newsVC.title = "News"
        favoritesVC.title = "Favorites"
        let tabBarItems = self.tabBar.items
        let images = ["house", "heart"]
        
        if let items = tabBarItems {
            for (index, _) in items.enumerated() {
                items[index].image = UIImage(systemName: images[index])
            }
        }
    }
    
    private func setupTabbarAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .systemBackground
            
            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
            
            appearance.stackedLayoutAppearance.selected.iconColor = CustomColor.buttonBackgroundColor
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: CustomColor.buttonBackgroundColor ?? .red]
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        } else {
            self.tabBar.barTintColor = .systemBackground
            self.tabBar.unselectedItemTintColor = .gray
            self.tabBar.tintColor = CustomColor.buttonBackgroundColor
        }
    }
}
