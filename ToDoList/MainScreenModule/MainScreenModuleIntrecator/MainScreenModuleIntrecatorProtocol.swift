import Foundation
protocol MainScreenModuleIntrecatorProtocol: AnyObject {
    func fetchTodos()
    func getAllToDos() -> [ToDo]
    func updateToDoStatus(toDo: ToDo, status: Bool)
}
