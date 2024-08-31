import UIKit

final class MainScreenModuleViewController: UIViewController {

    // MARK: - Private variables

    private var presenter: MainScreenModulePresenterProtocol

    // MARK: - UI components
    
    private lazy var toDoListTableView: UITableView = {
        var toDoListTableView = UITableView()
        toDoListTableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: "ToDoListTableViewCell")
        toDoListTableView.separatorStyle = .none
        toDoListTableView.estimatedRowHeight = 100
        toDoListTableView.rowHeight = UITableView.automaticDimension
        return toDoListTableView
    }()

    private lazy var toDoLabel: UILabel = {
        var toDoLabel = UILabel()
        toDoLabel.text = Resources.MainScreenModule.todoText
        toDoLabel.textColor = .black
        toDoLabel.font = .mainScreenTitileFont
        return toDoLabel
    }()

    private lazy var addButton: UIButton = {
        var addButton = UIButton()
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .black
        addButton.backgroundColor = .white
        addButton.layer.masksToBounds = false
        addButton.layer.cornerRadius = 25
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
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
        self.navigationController?.isNavigationBarHidden = true
        setupConstraints()
        presenter.viewDidLoad()
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        reloadData()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HELLOOOOOO")
        presenter.viewDidLoad()
    }

    // MARK: - Private methods

    private func setupConstraints() {
        [toDoListTableView, bottomView, addButton, toDoLabel].forEach {
            self.view.addSubview($0)
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
            toDoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            toDoListTableView.topAnchor.constraint(equalTo: toDoLabel.bottomAnchor),
            toDoListTableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            toDoListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toDoListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func addButtonTapped() {
        presenter.addButtonTapped()
    }
}

extension MainScreenModuleViewController: MainScreenModuleViewControllerProtocol {
    func reloadData() {
        toDoListTableView.reloadData()
    }
}

extension MainScreenModuleViewController: MainScreenModuleViewControllerCellProtocol {
    func doneButtonTapped(toDo: ToDo, indexPath: IndexPath) {
        presenter.toDoCompleted(toDo: toDo)
        view.isUserInteractionEnabled = false
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: {_ in
            self.toDoListTableView.deleteRows(at: [indexPath], with: .left)})
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {_ in
            self.presenter.intrecatorGotData()
            self.view.isUserInteractionEnabled = true
        })
    }
}

extension MainScreenModuleViewController: UITableViewDelegate {
    
}

extension MainScreenModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let toDos = presenter.getUncompletedToDos()
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDos = presenter.getUncompletedToDos()
        guard let cell = toDoListTableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as? ToDoListTableViewCell else { return UITableViewCell() }
        cell.view = self
        let toDo = toDos[indexPath.row]
        cell.toDo = toDo
        cell.indexPath = indexPath
        cell.configureUI(name: toDo.name!, status: toDo.status)
        return cell
    }
}
