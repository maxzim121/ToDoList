import UIKit
final class MainScreenModuleRouter {
    weak var presenter: MainScreenModulePresenterProtocol?
    weak var navigationController: UINavigationController?
}

extension MainScreenModuleRouter: MainScreenModuleRouterProtocol {
    func switchToToDoScreenModule(toDo: ToDo?) {
        guard let navigationController = navigationController else { return }
        let ToDoScreenModuleAssembly = ToDoScreenModuleAssembly()
        let View = ToDoScreenModuleAssembly.toDoScreenModuleAssembly(navigationController: navigationController, toDo: toDo)
        navigationController.pushViewController(View, animated: true)
    }
}
