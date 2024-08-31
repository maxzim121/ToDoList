import UIKit
final class MainScreenModulePresenter {
    
    weak var view: MainScreenModuleViewControllerProtocol?
    var intrecator: MainScreenModuleIntrecatorProtocol
    var router: MainScreenModuleRouterProtocol
    var toDos: [ToDo] = []
    var completedToDos: [ToDo] = []
    var uncompletedToDos: [ToDo] = []
    
    
    init(intrecator: MainScreenModuleIntrecatorProtocol, router: MainScreenModuleRouterProtocol) {
        self.router = router
        self.intrecator = intrecator
    }
    
    private func checkIfFirstLaunch() {
        if UserDefaults.standard.value(forKey: Resources.MainScreenModule.firstLaunchKey) == nil {
            intrecator.fetchTodos()
            UserDefaults.standard.setValue(0, forKey: Resources.MainScreenModule.firstLaunchKey)
        } else {
            intrecatorGotData()
        }
    }
    
}

extension MainScreenModulePresenter: MainScreenModulePresenterProtocol {
    
    
    func addButtonTapped() {
        print("почему")
        router.switchToCreateToDoScreenModule()
    }
    

    func viewDidLoad() {
        checkIfFirstLaunch()
    }
    
    func getUncompletedToDos() -> [ToDo] {
        uncompletedToDos = toDos.filter() { $0.status == false }
        return uncompletedToDos
    }
    
    func updateCompletedToDos(toDo: ToDo) {
        if let index = toDos.firstIndex(of: toDo) {
            toDos[index].status = true
        }
        view?.reloadData()
    }
    
    func getCompletedToDos() -> [ToDo] {
        completedToDos = toDos.filter() { $0.status == true }
        return completedToDos
    }
    
    func intrecatorGotData() {
        toDos = intrecator.getAllToDos()
        view?.reloadData()
    }
    
    func toDoCompleted(toDo: ToDo) {
        intrecator.completeToDo(toDo: toDo)
    }
}
