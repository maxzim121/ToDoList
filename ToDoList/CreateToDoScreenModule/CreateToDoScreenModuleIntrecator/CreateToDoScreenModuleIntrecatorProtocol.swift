import Foundation
protocol CreateToDoScreenModuleIntrecatorProtocol: AnyObject {
    func createNewToDo(name: String, description: String, date: Date, priority: String)
    func editToDo(name: String, description: String, date: Date, priority: String, toDo: ToDo)
    func deleteToDo(toDo: ToDo)
}
