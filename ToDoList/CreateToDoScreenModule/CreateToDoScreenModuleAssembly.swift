import UIKit
final class CreateToDoScreenModuleAssembly {
    func createScreenModuleAssembly(navigationController: UINavigationController, toDo: ToDo?) -> UIViewController {
        let router = CreateToDoScreenModuleRouter()
        let intrecator = CreateToDoScreenModuleIntrecator()
        let presenter = CreateToDoScreenModulePresenter(intrecator: intrecator, router: router)
        let view = CreateToDoScreenViewController(presenter: presenter)
        presenter.view = view
        presenter.toDo = toDo
        router.navigationController = navigationController
        return view
    }
}
