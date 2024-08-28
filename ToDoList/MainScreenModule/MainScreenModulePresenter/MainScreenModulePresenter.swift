import UIKit
final class MainScreenModulePresenter {
    
    weak var view: MainScreenModuleViewControllerProtocol?
    var intrecator: MainScreenModuleIntrecatorProtocol
    var toDos: [ToDo] = []
    
    init(intrecator: MainScreenModuleIntrecatorProtocol) {
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
    func viewDidLoad() {
        checkIfFirstLaunch()
    }
    
    func tableViewReloading() -> [ToDo] {
        return toDos
    }
    
    func intrecatorGotData() {
        toDos = intrecator.getAllToDos()
        view?.reloadData()
    }
}
