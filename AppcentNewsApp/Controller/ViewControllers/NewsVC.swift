import UIKit
import Alamofire

class NewsVC: UIViewController {
    
    //MARK: - Private Variales
    private let newsService: NewsService
    private var favoritesManager: FavoritesManaging
    
    private var currentSearchText: String?
    private var dataSource: [Article] = []
    
    private var currentPage = 1
    private var totalPage = 0
    private var isDataLoading = false
    private  var pageSize = 7  // API'den bir sayfada kaç tane veri geleceğini belirtir
    
    private var newsView: NewsView? {
        return self.view as? NewsView
    }
    
    //MARK: - Dependency Injection
    //MARK: - Initializers
    init(newsService: NewsService, favoritesManager: FavoritesManaging) {
        self.newsService = newsService
        self.favoritesManager = favoritesManager
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newsView = NewsView()
        let tableView = newsView.getTableView
        let tapGesture = newsView.getTapGesture
        tapGesture.addTarget(self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        newsView.addGestureRecognizer(tapGesture)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        let searchBar = newsView.getSearchBar
        searchBar.delegate = self
        
        self.view = newsView
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
   
    
    
    
    //MARK: - Pagination
    private func fetchMoreData() {
        if !isDataLoading && currentPage < totalPage {
            currentPage += 1
            fetchNews(searchQuery: currentSearchText!, page: currentPage)
        }
    }
    
    //MARK: - Private Functions
    
    private func fetchNews(searchQuery: String, page: Int) {
        guard !isDataLoading else { return }
        isDataLoading = true
        newsService.getNews(searchWord: searchQuery, page: page, pageSize: pageSize) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                switch result {
                case .success(let data):
                    
                    if data.status == "error" {
                        self.showErrorAlert(message: "You've made too many requests.")
                    } else if data.totalResults == 0 {
                        self.showErrorAlert(message: "No news matching the search term was found.")
                    } else {
                        self.dataSource.append(contentsOf: data.articles ?? [])
                        self.totalPage = (data.totalResults! + self.pageSize - 1) / self.pageSize
                        self.newsView?.getTableView.reloadData()
                    }
                case .failure(let error):
                    
                    self.showErrorAlert(message: "Haberler alınırken hata oluştu: \(error)")
                    print(error)
                }
                self.isDataLoading = false
            }
        }
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Appcent NewsApp"
        
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
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.clearSearchBar()
        }))
        self.present(alert, animated: true)
    }
    
    
    private func clearSearchBar() {
        self.newsView?.getSearchBar.text = ""
        self.currentSearchText = nil
        self.dataSource = []
        self.currentPage = 1
        self.newsView?.getTableView.reloadData()
        self.newsView?.showNoDataImageView()
        
    }
}

// MARK: - UITableViewDataSource
extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell {
            let data = dataSource[indexPath.row]
            cell.configure(with: data.title, description: data.description, imageURL: data.urlToImage)
            return cell
        }
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = dataSource[indexPath.row]
        let newViewController = NewsDetailVC(article:article, favoritesManager: favoritesManager )
        newViewController.hidesBottomBarWhenPushed = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 1 {
            fetchMoreData()
        }
    }
    
    
}

// MARK: - UISearchBarDelegate
extension NewsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            clearSearchBar()
            newsView?.showNoDataImageView()
        }else{
            newsView?.hideNoDataImageView()
        }
        currentSearchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text, !searchText.isEmpty {
            dataSource = []
            currentPage = 1
            fetchNews(searchQuery: searchText, page: currentPage)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        clearSearchBar()
    }
}


