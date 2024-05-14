import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    //MARK: - Private components
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .label
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        return label
    }()
    
    // Dinamik olarak değişebilen constraint
    private var titleLabelBottomConstraint: NSLayoutConstraint?
    
    //MARK: - init functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Setup Functions
    private func setup() {
        setupCellImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupCellImageView() {
        addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            cellImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 2),
            cellImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            cellImageView.heightAnchor.constraint(equalTo: cellImageView.widthAnchor)
            
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 2),
            titleLabel.trailingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: -16)
        ])
        
    }
    
    private func setupDescriptionLabel()  {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: cellImageView.bottomAnchor)
        ])
        titleLabelBottomConstraint = titleLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.topAnchor, multiplier: -2)
        titleLabelBottomConstraint?.isActive = true
        
    }
    
    //MARK: - Public Functions
    
    func configure(with title: String, description: String?, imageURL: String?) {
        titleLabel.text = title
        
        if let urlImage = imageURL, let URL = URL(string: urlImage) {
            cellImageView.kf.indicatorType = .activity
            cellImageView.kf.setImage(
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
            cellImageView.image = noImageIcon
        }
        
        
        
        if let descriptionText = description {
            descriptionLabel.text = descriptionText
            descriptionLabel.isHidden = false
            titleLabelBottomConstraint?.isActive = false
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8).isActive = true
        } else {
            titleLabel.numberOfLines = 0
            descriptionLabel.isHidden = true
            titleLabelBottomConstraint?.isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
            
        }
    }
    
}

//#Preview(""){
////    NewsVC()
//}
