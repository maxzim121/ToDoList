import UIKit
class HeaderView: UITableViewHeaderFooterView {
    
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        return titleLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureLabel(text: String) {
        titleLabel.text = text
    }
}
