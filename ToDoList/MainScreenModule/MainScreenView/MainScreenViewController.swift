import UIKit

final class MainScreenViewController: UIViewController {
    
    private lazy var toDoLabel: UILabel = {
        var toDoLabel = UILabel()
        toDoLabel.text = "ToDo"
        toDoLabel.textColor = .black
        toDoLabel.font = .systemFont(ofSize: 25, weight: .light)
        return toDoLabel
    }()
    
    private lazy var addButton: UIButton = {
        var addButton = UIButton()
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .black
        addButton.backgroundColor = .white
        addButton.layer.masksToBounds = false
        addButton.layer.cornerRadius = 25
        addButton.dropShadow()
        return addButton
    }()
    
    private lazy var bottomView: UIView = {
        var bottomView = UIView()
        bottomView.backgroundColor = .white
        bottomView.layer.masksToBounds = false
        bottomView.dropShadow()
        return bottomView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .white
    }

}

private extension MainScreenViewController {
    func setupConstraints() {
        [bottomView, addButton, toDoLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: bottomView.topAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            toDoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toDoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
