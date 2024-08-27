import UIKit
final class MainScreenModuleAssembly {
    func mainScreenModuleAssembly() -> UIViewController {
        let intrecator = MainScreenModuleIntrecator()
        let presenter = MainScreenModulePresenter(intrecator: intrecator)
        let viewController = MainScreenModuleViewController(presenter: presenter)
        presenter.view = viewController
        intrecator.presenter = presenter
        return viewController
    }
}
