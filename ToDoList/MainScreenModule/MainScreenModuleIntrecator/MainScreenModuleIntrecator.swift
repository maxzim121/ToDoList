import UIKit
final class MainScreenModuleIntrecator {
    
    weak var presenter: MainScreenModulePresenterProtocol?
    let networkClient = NetworkClient.shared
    let coreDataOperator = CoreDataOperator.shared
    var fetchedTodos: [Todo]?
    
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

extension MainScreenModuleIntrecator: MainScreenModuleIntrecatorProtocol {
    
    func getAllToDos() -> [ToDo] {
        return coreDataOperator.getAllItems()
    }
    
    func createToDo() {
        // TODO: Реализовать создание ToDo
    }
    
    func completeToDo(toDo: ToDo) {
        let backGroundContext = coreDataOperator.newBackgroundContext()
        backGroundContext.perform {
            self.coreDataOperator.completeToDo(item: toDo)
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
