import Foundation
protocol ToDoScreenModuleIntrecatorProtocol: AnyObject {
    func createNewToDo(name: String, description: String, date: Date, priority: String)
    func editToDo(name: String, description: String, date: Date, priority: String, toDo: ToDo)
    func deleteToDo(toDo: ToDo)
}
