import UIKit

typealias AllTodosCompletion = (Result<AllTodos, Error>) -> Void

final class NetworkClient {
    private let urlSession = URLSession.shared
    private var allTodosTask: URLSessionTask?
    static let shared = NetworkClient()
    
    func fetchTodos(completion: @escaping AllTodosCompletion) {
        assert(Thread.isMainThread)
        let request = allTodosRequest()
        allTodosTask = urlSession.object(urlSession: urlSession, for: request) { [weak self] (result: Result<AllTodos, Error>) in
            DispatchQueue.main.async {
                guard self != nil else {return}
                switch result {
                case .success(let todos):
                    completion(.success(todos))
                case .failure(let error):
                    completion(.failure(error))
                    assertionFailure("\(error)")
                }
            }
        }
    }
    
    func allTodosRequest() -> URLRequest {
        URLRequest.makeHTTPRequest(
            httpMethod: "get"
        )
    }
}
