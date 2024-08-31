import Foundation
final class CreateToDoScreenModulePresenter {
    
    weak var view: CreateToDoScreenViewControllerProtocol?
    var intrecator: CreateToDoScreenModuleIntrecatorProtocol
    var router: CreateToDoScreenModuleRouterProtocol
    
    var toDo: ToDo?
    
    private var nameText: String?
    private var descriptionText: String?
    private var priorityText: String?
    private var date: Date?
    
    init(intrecator: CreateToDoScreenModuleIntrecatorProtocol, router: CreateToDoScreenModuleRouterProtocol) {
        self.intrecator = intrecator
        self.router = router
    }
    
}

extension CreateToDoScreenModulePresenter: CreateToDoScreenModulePresenterProtocol {
    func tryToCreate() {
        guard let nameText = nameText,
              let descriptionText = descriptionText,
              let date = date,
              let priorityText = priorityText else {
            // Метод отображения ошибки
            view?.showAlert()
            return
        }
        if nameText == "" {
            view?.showAlert()
            return
        }
        if descriptionText == "" {
            view?.showAlert()
            return
        }
        if let toDo = toDo {
            intrecator.editToDo(name: nameText, description: descriptionText, date: date, priority: priorityText, toDo: toDo)
        } else {
            intrecator.createNewToDo(name: nameText, description: descriptionText, date: date, priority: priorityText)
        }
        router.switchToMainScreen()
    }
    
    func switchToMainScreen() {
        router.switchToMainScreen()
    }
    
    func nameEdited(name: String) {
        nameText = name
    }
    
    func descriptionEdited(description: String) {
        descriptionText = description
    }
    
    func dateEdited(date: Date) {
        self.date = date
    }
    
    func priorityEdited(priority: String) {
        priorityText = priority
    }
    
    func viewDidLoad() {
        if let toDo = toDo {
            view?.setupWithToDo(toDo: toDo)
        }
    }
    
    func deleteToDo() {
        guard let toDo = toDo else { return }
        intrecator.deleteToDo(toDo: toDo)
        router.switchToMainScreen()
    }
}
