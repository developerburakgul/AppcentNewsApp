//
//  NewsDetailView.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 11.05.2024.
//






import UIKit

class NewsDetailView: UIView {

    
    //MARK: - Private Variables/Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: "teacher") // When i write code , this assigment helped me for the autolayout and show my codes effect
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .label
//        label.text = "at auctor urna nunc id cursus metus aliquam eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque purus semper eget duis at tellus at urna condimentum mattis pellentesque id nibh tortor id aliquet lectus proin nibh nisl condimentum id venenatis a condimentum vitae sapien pellentesque habitant morbi tristique senectus et netus et malesuada" // When i write code , this assigment helped me for the autolayout and show my codes effect
        return label
    }()
    
    private let authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
//        stackView.backgroundColor = .systemPink // When i write code , this assigment helped me for the autolayout and show my codes effect
        return stackView
    }()
    
    private let authorIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "book.pages")
        imageView.tintColor = CustomColor.buttonBackgroundColor
        return imageView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        label.textColor = .label
//        label.text = "Burak Gül" // When i write code , this assigment helped me for the autolayout and show my codes effect
        
        return label
    }()
    
    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
//        stackView.backgroundColor = .systemOrange // When i write code , this assigment helped me for the autolayout and show my codes effect
        return stackView
    }()
    
    private let dateIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        var calendarImage = UIImage(systemName: "calendar")
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .large)
        let largeImage = calendarImage?.withConfiguration(largeConfig)
        imageView.image = largeImage
        imageView.tintColor = CustomColor.buttonBackgroundColor
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        label.textColor = .label
//        label.text = "11.05.2024" // When i write code , this assigment helped me for the autolayout and show my codes effect
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
//        label.text = "at auctor urna nunc id cursus metus aliquam eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque purus semper eget duis at tellus at urna condimentum mattis pellentesque id nibh tortor id aliquet lectus proin nibh nisl " // When i write code , this assigment helped me for the autolayout and show my codes effect
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let bottomView: UIView = {
        let bottomView = UIView()
//        bottomView.backgroundColor = .systemPink // When i write code , this assigment helped me for the autolayout and show my codes effect
        return bottomView
    }()
    
    private let sourceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("News Source", for: .normal)
        button.backgroundColor = CustomColor.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    //MARK: - Public Variables/Getters
    var getSourceButton : UIButton {
        return sourceButton
    }
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Setup Functions
    private func setup() {
        setupScrollView()
        setupImageView()
        setupTitleLabel()
        setupAuthorStackView()
        setupDateStackView()
        setupContentLabel()
        setupBottomView()
        setupNavigateButton()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupImageView() {
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: scrollView.topAnchor, multiplier: 4),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }
    
    private func setupAuthorStackView() {
        authorStackView.addArrangedSubview(authorIconImageView)
        authorStackView.addArrangedSubview(authorLabel)
        
        scrollView.addSubview(authorStackView)
        authorStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorStackView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            authorStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorStackView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 0.5)
        ])
        
        authorIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorIconImageView.widthAnchor.constraint(equalTo: authorStackView.heightAnchor),
            authorIconImageView.heightAnchor.constraint(equalTo: authorStackView.heightAnchor)
        ])
    }
    
    private func setupDateStackView() {
        dateStackView.addArrangedSubview(dateIconImageView)
        dateStackView.addArrangedSubview(dateLabel)
        
        scrollView.addSubview(dateStackView)
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: authorStackView.topAnchor),
            dateStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: authorStackView.trailingAnchor, multiplier: 1),
            dateStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        dateIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateIconImageView.widthAnchor.constraint(equalTo: authorStackView.heightAnchor),
            dateIconImageView.heightAnchor.constraint(equalTo: authorStackView.heightAnchor)
        ])
    }
    
    private func setupContentLabel() {
        scrollView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalToSystemSpacingBelow: authorStackView.bottomAnchor, multiplier: 1),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            contentLabel.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupBottomView() {
        addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalToSystemSpacingBelow: self.safeAreaLayoutGuide.bottomAnchor, multiplier: -5)
        ])
    }
    
    private func setupNavigateButton() {
        bottomView.addSubview(sourceButton)
        sourceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sourceButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            sourceButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            sourceButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.7),
            sourceButton.widthAnchor.constraint(equalTo: sourceButton.heightAnchor, multiplier: 3)
        ])
    }
    
    //MARK: - Public Functions
    func configure(with article: Article) {
        
        if let urlImage = article.urlToImage, let URL = URL(string: urlImage) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: URL,
                placeholder: nil,
                options: [
                    .transition(.fade(0.2)),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ]) { result in
                    switch result {
                    case .success(let value):
                        print("Image set successfully: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Error setting image: \(error.localizedDescription)")
                    }
                }
        } else {
            
            let noImageIcon = UIImage(systemName: "photo")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            imageView.image = noImageIcon
        }
        titleLabel.text = article.title
        authorLabel.text = article.author ?? "Not Found"
        dateLabel.text = article.publishedAt.toDate()?.toCustomString()
        contentLabel.text = article.content
        
    }
    
}

