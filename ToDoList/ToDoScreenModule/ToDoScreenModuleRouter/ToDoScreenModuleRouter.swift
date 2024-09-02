import UIKit
final class ToDoScreenModuleRouter {
    
    // MARK: - Public properties
    
    weak var navigationController: UINavigationController?
}

    // MARK: - ToDoScreenModuleRouterProtocol

extension ToDoScreenModuleRouter: ToDoScreenModuleRouterProtocol {
    func switchToMainScreen() {
        navigationController?.popViewController(animated: true)
    }
}
