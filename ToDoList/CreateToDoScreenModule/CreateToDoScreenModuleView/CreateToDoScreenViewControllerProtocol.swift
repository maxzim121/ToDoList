import Foundation
protocol CreateToDoScreenViewControllerProtocol: AnyObject {
    func showAlert()
    func setupWithToDo(toDo: ToDo)
}
