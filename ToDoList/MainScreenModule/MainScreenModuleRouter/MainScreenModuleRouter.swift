import UIKit
final class MainScreenModuleRouter {
    weak var presenter: MainScreenModulePresenterProtocol?
    weak var navigationController: UINavigationController?
}

extension MainScreenModuleRouter: MainScreenModuleRouterProtocol {
    func switchToCreateToDoScreenModule(toDo: ToDo?) {
        guard let navigationController = navigationController else { return }
        let createToDoScreenModuleAssembly = CreateToDoScreenModuleAssembly()
        let createView = createToDoScreenModuleAssembly.createScreenModuleAssembly(navigationController: navigationController, toDo: toDo)
        navigationController.pushViewController(createView, animated: true)
    }
}
