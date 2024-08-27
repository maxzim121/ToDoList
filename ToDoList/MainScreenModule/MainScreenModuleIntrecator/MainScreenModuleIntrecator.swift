import UIKit
final class MainScreenModuleIntrecator {
    
    weak var presenter: MainScreenModulePresenterProtocol?
    let networkClient = NetworkClient.shared
    var fetchedTodos: [Todo]?
    
}

extension MainScreenModuleIntrecator: MainScreenModuleIntrecatorProtocol {
    func fetchTodos() {
        networkClient.fetchTodos() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.fetchedTodos = response.todos
                presenter?.dataCollected(response.todos)
            case .failure(let error):
                assertionFailure("\(error)")
            }
        }
    }
}
