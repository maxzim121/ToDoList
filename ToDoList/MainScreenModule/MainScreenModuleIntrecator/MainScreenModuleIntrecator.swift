import UIKit
final class MainScreenModuleIntrecator {
    
    // MARK: - Public properties
    
    weak var presenter: MainScreenModulePresenterProtocol?
    
    // MARK: - Private properties
    
    private let networkClient = NetworkClient.shared
    private let coreDataOperator = CoreDataOperator.shared
    private var fetchedTodos: [Todo]?
    
    // MARK: - Public methods
    
    func createFetchedToDos() {
        let backGroundContext = coreDataOperator.newBackgroundContext()
        backGroundContext.perform {
            self.fetchedTodos?.forEach { item in
                self.coreDataOperator.createFetchedItem(name: item.todo, status: item.completed, context: backGroundContext)
            }
            DispatchQueue.main.async {
                self.presenter?.intrecatorGotData()
            }
        }
    }
    
}

    // MARK: - MainScreenModuleIntrecatorProtocol

extension MainScreenModuleIntrecator: MainScreenModuleIntrecatorProtocol {
    
    func getAllToDos() -> [ToDo] {
        return coreDataOperator.getAllItems()
    }
    
    func updateToDoStatus(toDo: ToDo, status: Bool) {
            let backGroundContext = coreDataOperator.newBackgroundContext()
            backGroundContext.perform {
                self.coreDataOperator.completeToDo(item: toDo, status: status)
            }
    }
    
    func fetchTodos() {
        networkClient.fetchTodos() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.fetchedTodos = response.todos
                self.createFetchedToDos()
            case .failure(let error):
                assertionFailure("\(error)")
            }
        }
    }
}
