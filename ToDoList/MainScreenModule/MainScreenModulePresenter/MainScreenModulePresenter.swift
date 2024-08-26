import UIKit
final class MainScreenModulePresenter {
    
    weak var view: MainScreenModuleViewControllerProtocol?
    var intrecator: MainScreenModuleIntrecatorProtocol
    
    init(intrecator: MainScreenModuleIntrecatorProtocol) {
        self.intrecator = intrecator
    }
    
}

extension MainScreenModulePresenter: MainScreenModulePresenterProtocol {
    func dataCollected(_ data: [Todo]) {
        view?.showData(data)
    }
    
    func viewDidLoad() {
        intrecator.fetchTodos()
    }
}
