import UIKit
final class ToDoScreenModuleRouter {
    weak var navigationController: UINavigationController?
}
extension ToDoScreenModuleRouter: ToDoScreenModuleRouterProtocol {
    func switchToMainScreen() {
        navigationController?.popViewController(animated: true)
    }
}
