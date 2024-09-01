import Foundation
enum Resources {
    enum MainScreenModule {
        static let firstLaunchKey = "firstLaunch"
        static let todoText = "ToDo"
        static let completedHeaderText = "Невыполненные"
        static let uncompletedHeaderText = "Выполненные"
        static let lowText = "Low"
        static let midText = "Mid"
        static let highText = "High"
        static let toDoListCellReuseIdentifierText = "ToDoListTableViewCell"
        static let headerReuseIdentifier = "header"
    }
    enum ToDoScreen {
        static let lowText = "Low"
        static let midText = "Mid"
        static let highText = "High"
        static let createText = "Создать"
        static let deleteText = "Удалить"
        static let saveText = "Сохранить"
        static let addToDo = "Добавьте задачу..."
        static let addDescription = "Добавьте описание..."
        static let alertTitleText = "Не получилось создать задачу"
        static let alertMessageText = "Убедитесь что все поля заполнены"
        static let okText = "ОК"
        
        
        static let priorityCellReuseIdentifierText = "priotiryCell"
    }
    static let fatalErrorText = "init(coder:) has not been implemented"
}
let mainResources = Resources.MainScreenModule.self
let toDoScreenResources = Resources.ToDoScreen.self
