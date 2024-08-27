import Foundation
protocol MainScreenModulePresenterProtocol: AnyObject {
    func viewDidLoad()
    func dataCollected(_ data: [Todo])
}
