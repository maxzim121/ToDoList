import Foundation
protocol MainScreenModulePresenterProtocol: AnyObject {
    func viewDidLoad()
    func tableViewReloading() -> [ToDo]
    func intrecatorGotData()
}
