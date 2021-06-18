import Foundation

public struct EmptyResponse: Decodable {}

public protocol Requestable {
  associatedtype ResponseType: Decodable
  var path: String { get }
  func request(completion: @escaping (Result<ResponseType, RequestError>) -> Void) -> URLSessionDataTask
}

public extension Requestable {
  func request(completion: @escaping (Result<ResponseType, RequestError>) -> Void) -> URLSessionDataTask {
    let url = Configs.baseURL.appendingPathComponent(path)

    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        completion(.failure(.dataTask(error)))
        return
      }

      guard let data = data else {
        completion(.failure(.onData))
        return
      }

      do {
        let value = try JSONDecoder().decode(ResponseType.self, from: data)
        completion(.success(value))
      } catch {
        completion(.failure(.parsing(error)))
      }
    }

    task.resume()
    return task
  }
}
