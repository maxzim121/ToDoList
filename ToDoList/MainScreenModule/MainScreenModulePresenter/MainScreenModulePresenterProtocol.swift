import UIKit
protocol MainScreenModulePresenterProtocol: AnyObject {
    func viewDidLoad()
    func getUncompletedToDos() -> [ToDo]
    func getCompletedToDos() -> [ToDo]
    func updateCompletedToDos(toDo: ToDo)
    func intrecatorGotData()
    func toDoCompleted(toDo: ToDo)
    func addButtonTapped(toDo: ToDo?)
}
