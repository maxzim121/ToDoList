import UIKit
final class CreateToDoScreenModuleAssembly {
    func createScreenModuleAssembly(navigationController: UINavigationController) -> UIViewController {
        let router = CreateToDoScreenModuleRouter()
        let intrecator = CreateToDoScreenModuleIntrecator()
        let presenter = CreateToDoScreenModulePresenter(intrecator: intrecator, router: router)
        let view = CreateToDoScreenViewController(presenter: presenter)
        presenter.view = view
        router.navigationController = navigationController
        return view
    }
}
