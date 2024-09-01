import UIKit
final class PriorityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private lazy var priorityLabel: UILabel = {
        var priorityLabel = UILabel()
        priorityLabel.font = .toDoNameFont
        priorityLabel.textColor = .black
        return priorityLabel
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Resources.fatalErrorText)
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        contentView.addSubview(priorityLabel)
        contentView.layer.borderColor = UIColor.black.cgColor
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        priorityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        priorityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    // MARK: - Public methods
    
    func cellSelected() {
        contentView.layer.borderWidth = 3
    }
    
    func cellDeselected() {
        contentView.layer.borderWidth = 0
    }
    
    func lowCell() {
        contentView.backgroundColor = .blue.withAlphaComponent(0.5)
        priorityLabel.text = toDoScreenResources.lowText
    }
    func midCell() {
        contentView.backgroundColor = .yellow.withAlphaComponent(0.5)
        priorityLabel.text = toDoScreenResources.midText
    }
    func highCell() {
        contentView.backgroundColor = .red.withAlphaComponent(0.5)
        priorityLabel.text = toDoScreenResources.highText
    }
    
}
