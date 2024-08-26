import UIKit
final class MainScreenModulePresenter {
    
    weak var view: MainScreenModuleViewControllerProtocol?
    var intrecator: MainScreenModuleIntrecatorProtocol
    
    init(intrecator: MainScreenModuleIntrecatorProtocol) {
        self.intrecator = intrecator
    }
    
    private func checkIfFirstLaunch() {
        if UserDefaults.standard.value(forKey: Resources.MainScreenModule.firstLaunchKey) == nil {
            intrecator.fetchTodos()
            UserDefaults.standard.setValue(0, forKey: Resources.MainScreenModule.firstLaunchKey)
        }
    }
    
}

extension MainScreenModulePresenter: MainScreenModulePresenterProtocol {
    func dataCollected(_ data: [Todo]) {
        view?.showData(data)
    }
    
    func viewDidLoad() {
        checkIfFirstLaunch()
    }
}
