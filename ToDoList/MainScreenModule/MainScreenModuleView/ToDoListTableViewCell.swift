import UIKit
final class ToDoListTableViewCell: UITableViewCell {
    
    weak var view: MainScreenModuleViewControllerCellProtocol?
    var toDo: ToDo?
    var indexPath: IndexPath?
    
    private var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private var descriptionLabel: UILabel = {
        var descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 2
        return descriptionLabel
    }()
    
    private var dateBackgroundView: UIView = {
        var dateBackgroundView = UIView()
        dateBackgroundView.backgroundColor = .white
        dateBackgroundView.layer.cornerRadius = 16
        dateBackgroundView.layer.borderWidth = 0.5
        dateBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        return dateBackgroundView
    }()
    
    private lazy var toDoNameLabel: UILabel = {
        var toDoNameLabel = UILabel()
        toDoNameLabel.font = .systemFont(ofSize: 16)
        toDoNameLabel.numberOfLines = 2
        return toDoNameLabel
    }()
    
    private lazy var statusButton: UIImageView = {
        var statusButton = UIImageView()
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(doneButtonTapped))
        statusButton.contentMode = .scaleAspectFit
        statusButton.addGestureRecognizer(tapGesture)
        statusButton.isUserInteractionEnabled = true
        return statusButton
    }()
    
    private lazy var dateLabel: UILabel = {
        var dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.backgroundColor = .clear
        return dateLabel
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        toDoNameLabel.text = nil
        toDoNameLabel.attributedText = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
        descriptionLabel.isHidden = true
        dateBackgroundView.isHidden = true
        toDo = nil
        indexPath = nil
        stackView.spacing = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        [statusButton, dateBackgroundView, stackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            statusButton.widthAnchor.constraint(equalToConstant: 30),
            statusButton.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.leadingAnchor.constraint(equalTo: statusButton.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        stackView.addArrangedSubview(toDoNameLabel)
    }
    
    @objc func doneButtonTapped() {
        UIView.transition(
            with: statusButton,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: { [self] in 
                self.statusButton.image = UIImage(systemName: "checkmark")
                guard let toDo = self.toDo,
                      let indexPath = self.indexPath else { return }
                view?.doneButtonTapped(toDo: toDo, indexPath: indexPath)
                })
    }
    
    
    
    func configureUI(name: String?, description: String?, date: Date?, priority: String?, status: Bool?) {
        var descriptionIsNil: Bool = true
        
        if let name = name {
            toDoNameLabel.text = name
        }
        if let description = description {
            descriptionIsNil = false
            configureDescriptionLabel(description: description)
        } else {
        }
        if let date = date {
            configureDateLabel(date: date, descriptionIsNil: descriptionIsNil)
        } else {
        }
        if let priority = priority {
            switch priority {
            case "Low":
                statusButton.tintColor = .blue.withAlphaComponent(0.5)
            case "Mid":
                statusButton.tintColor = .yellow.withAlphaComponent(0.8)
            case "High":
                statusButton.tintColor = .red.withAlphaComponent(0.5)
            default: break
            }
        } else {
            statusButton.tintColor = .lightGray
        }
        if let status = status {
            guard let name = name else { return }
            if status == true {
                statusButton.image = UIImage(systemName: "checkmark")
            } else {
                statusButton.image = UIImage(systemName: "circle")
            }
        }
    }
    
    func configureDescriptionLabel(description: String) {
        stackView.spacing = 10
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = description
        descriptionLabel.isHidden = false
    }
    
    func configureDateLabel(date: Date, descriptionIsNil: Bool) {
        stackView.spacing = 10
        [dateLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        dateBackgroundView.isHidden = false
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        dateLabel.text = formatter.string(from: date)
        NSLayoutConstraint.activate([
            dateBackgroundView.widthAnchor.constraint(equalToConstant: 93),
            dateBackgroundView.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            dateBackgroundView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -10),
            dateBackgroundView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
