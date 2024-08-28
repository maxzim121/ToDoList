import Foundation
protocol MainScreenModuleIntrecatorProtocol: AnyObject {
    func fetchTodos()
    func createToDo()
    func getAllToDos() -> [ToDo]
}
