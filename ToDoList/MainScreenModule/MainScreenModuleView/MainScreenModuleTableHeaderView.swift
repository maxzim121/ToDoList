import UIKit
class HeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Private properties
    
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = .headerFont
        return titleLabel
    }()
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // MARK: - Public methods
    
    func configureLabel(text: String) {
        titleLabel.text = text
    }
}
