import UIKit
final class ToDoScreenModuleAssembly {
    func toDoScreenModuleAssembly(navigationController: UINavigationController, toDo: ToDo?) -> UIViewController {
        let router = ToDoScreenModuleRouter()
        let intrecator = ToDoScreenModuleIntrecator()
        let presenter = ToDoScreenModulePresenter(intrecator: intrecator, router: router)
        let view = ToDoScreenViewController(presenter: presenter)
        presenter.view = view
        presenter.toDo = toDo
        router.navigationController = navigationController
        return view
    }
}
