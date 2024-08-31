import Foundation
final class CreateToDoScreenModuleIntrecator {
    weak var presenter: CreateToDoScreenModulePresenterProtocol?
    let coreDataOperator = CoreDataOperator.shared
}
extension CreateToDoScreenModuleIntrecator: CreateToDoScreenModuleIntrecatorProtocol {
    func createNewToDo(name: String, description: String, date: Date, priority: String) {
        DispatchQueue.global().sync {
            self.coreDataOperator.createItem(name: name, description: description, date: date, priority: priority)
        }
    }
    
    func editToDo(name: String, description: String, date: Date, priority: String, toDo: ToDo) {
        DispatchQueue.global().sync {
            self.coreDataOperator.updateItem(name: name, description: description, date: date, priority: priority, item: toDo)
        }
    }
    
    func deleteToDo(toDo: ToDo) {
        DispatchQueue.global().sync {
            self.coreDataOperator.deleteItem(item: toDo)
        }
    }
}
