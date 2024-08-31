import UIKit
final class PriorityCollectionViewCell: UICollectionViewCell {
    
    private lazy var priorityLabel: UILabel = {
        var priorityLabel = UILabel()
        priorityLabel.font = .systemFont(ofSize: 16)
        priorityLabel.textColor = .black
        return priorityLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(priorityLabel)
        contentView.layer.borderColor = UIColor.black.cgColor
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        priorityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        priorityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func cellSelected() {
        contentView.layer.borderWidth = 3
    }
    
    func cellDeselected() {
        contentView.layer.borderWidth = 0
    }
    
    func lowCell() {
        contentView.backgroundColor = .blue.withAlphaComponent(0.5)
        priorityLabel.text = "Low"
    }
    func midCell() {
        contentView.backgroundColor = .yellow.withAlphaComponent(0.5)
        priorityLabel.text = "Mid"
    }
    func highCell() {
        contentView.backgroundColor = .red.withAlphaComponent(0.5)
        priorityLabel.text = "High"
    }
    
}
