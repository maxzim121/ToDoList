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
}
