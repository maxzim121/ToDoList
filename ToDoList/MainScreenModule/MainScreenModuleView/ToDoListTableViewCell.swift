import UIKit
final class ToDoListTableViewCell: UITableViewCell {
    
    weak var view: MainScreenModuleViewControllerCellProtocol?
    var toDo: ToDo?
    var indexPath = IndexPath()
    
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
        statusButton.tintColor = .red
        statusButton.contentMode = .scaleAspectFit
        statusButton.addGestureRecognizer(tapGesture)
        statusButton.isUserInteractionEnabled = true
        return statusButton
    }()
    
    private lazy var dateLabel: UILabel = {
        var dateLabel = UILabel()
        dateLabel.text = "SEPTEMBERE"
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.backgroundColor = .clear
        return dateLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        [toDoNameLabel, statusButton, dateBackgroundView, dateLabel, ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            statusButton.widthAnchor.constraint(equalToConstant: 30),
            statusButton.heightAnchor.constraint(equalToConstant: 30),
            
            toDoNameLabel.leadingAnchor.constraint(equalTo: statusButton.trailingAnchor, constant: 20),
            toDoNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            toDoNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            dateBackgroundView.leadingAnchor.constraint(equalTo: toDoNameLabel.leadingAnchor),
            dateBackgroundView.topAnchor.constraint(equalTo: toDoNameLabel.bottomAnchor,constant: 10),
            dateBackgroundView.heightAnchor.constraint(equalToConstant: 30),
            dateBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            dateLabel.centerXAnchor.constraint(equalTo: dateBackgroundView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: dateBackgroundView.centerYAnchor),
            
            dateBackgroundView.widthAnchor.constraint(equalTo: dateLabel.widthAnchor, constant: 20)
        ])
    }
    
    @objc func doneButtonTapped() {
        UIView.transition(
            with: statusButton,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: { [self] in 
                self.statusButton.image = UIImage(systemName: "checkmark")
                guard let toDo = self.toDo else { return }
                view?.doneButtonTapped(toDo: toDo, indexPath: self.indexPath)
                })
    }
    
    
    
    func configureUI(name: String, status: Bool) {
        toDoNameLabel.text = name
        statusButton.image = UIImage(systemName: "circle")
    }
    
}
