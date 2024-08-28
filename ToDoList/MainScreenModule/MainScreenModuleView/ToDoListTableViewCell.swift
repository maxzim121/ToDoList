import UIKit
final class ToDoListTableViewCell: UITableViewCell {
    
    private lazy var toDoNameLabel: UILabel = {
        var toDoNameLabel = UILabel()
        toDoNameLabel.font = .systemFont(ofSize: 16)
        toDoNameLabel.numberOfLines = 0
        return toDoNameLabel
    }()
    
    private lazy var statusButton: UIButton = {
        var statusButton = UIButton()
        return statusButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        [toDoNameLabel, statusButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            statusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            statusButton.widthAnchor.constraint(equalToConstant: 44),
            statusButton.heightAnchor.constraint(equalToConstant: 44),
            
            toDoNameLabel.leadingAnchor.constraint(equalTo: statusButton.trailingAnchor),
            toDoNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            toDoNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            toDoNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func configureUI(name: String, status: Bool) {
        toDoNameLabel.text = name
        if status {
            statusButton.setImage(UIImage(systemName: "cloud"), for: .normal)
        } else {
            statusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        }
    }
    
}
