import UIKit
final class CreateToDoScreenModuleRouter {
    weak var navigationController: UINavigationController?
}
extension CreateToDoScreenModuleRouter: CreateToDoScreenModuleRouterProtocol {
    func switchToMainScreen() {
        navigationController?.popViewController(animated: true)
    }
}
