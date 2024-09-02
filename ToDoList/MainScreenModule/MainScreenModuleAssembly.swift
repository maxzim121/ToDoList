import UIKit
final class MainScreenModuleAssembly {
    func mainScreenModuleAssembly(navigationController: UINavigationController) -> UIViewController {
        let intrecator = MainScreenModuleIntrecator()
        let router = MainScreenModuleRouter()
        let presenter = MainScreenModulePresenter(intrecator: intrecator, router: router)
        let viewController = MainScreenModuleViewController(presenter: presenter)
        presenter.view = viewController
        intrecator.presenter = presenter
        router.presenter = presenter
        router.navigationController = navigationController
        return viewController
    }
}
