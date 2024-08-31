import Foundation
protocol ToDoScreenViewControllerProtocol: AnyObject {
    func showAlert()
    func setupWithToDo(toDo: ToDo)
}
