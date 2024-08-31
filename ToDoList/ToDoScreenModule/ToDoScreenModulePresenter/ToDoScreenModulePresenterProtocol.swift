import Foundation
protocol ToDoScreenModulePresenterProtocol: AnyObject {
    func tryToCreate()
    func nameEdited(name: String)
    
    func descriptionEdited(description: String)
    
    func dateEdited(date: Date)
    
    func priorityEdited(priority: String)
    
    func switchToMainScreen()
    
    func viewDidLoad()
    func deleteToDo()
}
