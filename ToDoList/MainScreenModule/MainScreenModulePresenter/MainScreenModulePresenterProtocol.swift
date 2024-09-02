import UIKit
protocol MainScreenModulePresenterProtocol: AnyObject {
    func viewDidLoad()
    func getUncompletedToDos() -> [ToDo]
    func getCompletedToDos() -> [ToDo]
    func updateCompletedToDos(toDo: ToDo)
    func intrecatorGotData()
    func updateToDoStatus(toDo: ToDo, status: Bool)
    func addButtonTapped(toDo: ToDo?)
}
