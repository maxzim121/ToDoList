import UIKit

final class MainScreenModuleViewController: UIViewController {

    // MARK: - Private variables

    private var presenter: MainScreenModulePresenterProtocol

    // MARK: - UI components
    
    private lazy var toDoListTableView: UITableView = {
        var toDoListTableView = UITableView()
        toDoListTableView.showsVerticalScrollIndicator = false
        toDoListTableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: "ToDoListTableViewCell")
        toDoListTableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        toDoListTableView.separatorStyle = .none
        toDoListTableView.estimatedRowHeight = 100
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
        presenter.addButtonTapped(toDo: nil)
    }
}

extension MainScreenModuleViewController: MainScreenModuleViewControllerProtocol {
    func reloadData() {
        toDoListTableView.reloadData()
    }
}

extension MainScreenModuleViewController: MainScreenModuleViewControllerCellProtocol {
    func doneButtonTapped(toDo: ToDo, indexPath: IndexPath) {
        presenter.updateToDoStatus(toDo: toDo, status: toDo.status)
        if indexPath.section == 0 {
            toDoListTableView.performBatchUpdates({
                toDoListTableView.deleteRows(at: [indexPath], with: .left)
                let newIndexPath = IndexPath(row: presenter.getCompletedToDos().count - 1, section: 1)
                toDoListTableView.insertRows(at: [newIndexPath], with: .automatic)
            }, completion: { _ in
                self.toDoListTableView.reloadData()
            })
        } else {
            toDoListTableView.performBatchUpdates({
                toDoListTableView.deleteRows(at: [indexPath], with: .left)
                let newIndexPath = IndexPath(row: presenter.getUncompletedToDos().count - 1, section: 0)
                toDoListTableView.insertRows(at: [newIndexPath], with: .automatic)
            }, completion: { _ in
                self.toDoListTableView.reloadData()
            })
        }
    }
}

extension MainScreenModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ToDoListTableViewCell
        let toDo = cell?.toDo
        presenter.addButtonTapped(toDo: toDo)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HeaderView else { return UIView()}
        switch section {
        case 0:
            let count = presenter.getUncompletedToDos().count
            if count == 0 {
                return UIView()
            }
            header.configureLabel(text: "Невыполненные (\(count))")
        case 1:
            let count = presenter.getCompletedToDos().count
            if count == 0 {
                return UIView()
            }
            header.configureLabel(text: "Выполненные (\(count))")
        default: return UIView()
        }
        return header
    }
}

extension MainScreenModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            let toDos = presenter.getUncompletedToDos()
            return toDos.count
        case 1:
            let toDos = presenter.getCompletedToDos()
            return toDos.count
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let toDos = presenter.getUncompletedToDos()
            guard let cell = toDoListTableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as? ToDoListTableViewCell else { return UITableViewCell() }
            cell.view = self
            let toDo = toDos[indexPath.row]
            cell.toDo = toDo
            cell.indexPath = indexPath
            cell.configureUI(name: toDo.name, description: toDo.descriptioin, date: toDo.date, priority: toDo.priority, status: toDo.status)
            return cell
        case 1:
            let toDos = presenter.getCompletedToDos()
            guard let cell = toDoListTableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as? ToDoListTableViewCell else { return UITableViewCell() }
            cell.view = self
            let toDo = toDos[indexPath.row]
            cell.toDo = toDo
            cell.indexPath = indexPath
            cell.configureUI(name: toDo.name, description: nil, date: nil, priority: toDo.priority, status: toDo.status)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
