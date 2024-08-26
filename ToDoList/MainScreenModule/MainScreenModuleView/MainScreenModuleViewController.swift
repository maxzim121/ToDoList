import UIKit

final class MainScreenModuleViewController: UIViewController {

    // MARK: - Private variables

    private var presenter: MainScreenModulePresenterProtocol

    // MARK: - UI components

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

    // MARK: - Initialization

    init(presenter: MainScreenModulePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        presenter.viewDidLoad()
        view.backgroundColor = .white
    }

    // MARK: - Private methods

    private func setupConstraints() {
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

extension MainScreenModuleViewController: MainScreenModuleViewControllerProtocol {
    func showData(_ data: [Todo]) {
        print(data)
    }
}
