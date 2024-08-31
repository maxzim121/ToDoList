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
    
    func addButtonTapped(toDo: ToDo?) {
        router.switchToToDoScreenModule(toDo: toDo)
    }
    

    func viewDidLoad() {
        checkIfFirstLaunch()
    }
    
    func getUncompletedToDos() -> [ToDo] {
        return uncompletedToDos
    }
    
    func updateCompletedToDos(toDo: ToDo) {
        if let index = toDos.firstIndex(of: toDo) {
            toDos[index].status = true
        }
        view?.reloadData()
    }
    
    func getCompletedToDos() -> [ToDo] {
        return completedToDos
    }
    
    func intrecatorGotData() {
        toDos = intrecator.getAllToDos()
        completedToDos = toDos.filter() { $0.status == true }
        uncompletedToDos = toDos.filter() { $0.status == false }
        view?.reloadData()
    }
    
    func updateToDoStatus(toDo: ToDo, status: Bool) {
        if status {
            if let index = completedToDos.firstIndex(where: { $0.id == toDo.id }) {
                completedToDos[index].status = !status
                uncompletedToDos.append(completedToDos.remove(at: index))
            }
        } else {
            if let index = uncompletedToDos.firstIndex(where: { $0.id == toDo.id }) {
                uncompletedToDos[index].status = !status
                completedToDos.append(uncompletedToDos.remove(at: index))
            }
        }
        intrecator.updateToDoStatus(toDo: toDo, status: status)
    }
}
