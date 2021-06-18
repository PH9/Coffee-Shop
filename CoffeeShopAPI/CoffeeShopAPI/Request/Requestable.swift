import Foundation

public struct EmptyResponse: Decodable {}

public protocol Requestable {
  associatedtype ResponseType: Decodable
  var path: String { get }
  var expectedStatusCode: ClosedRange<Int> { get }
  func request(completion: @escaping (Result<ResponseType, RequestError>) -> Void) -> URLSessionDataTask
}

public extension Requestable {
  var expectedStatusCode: ClosedRange<Int> {
    200 ... 299
  }

  func request(completion: @escaping (Result<ResponseType, RequestError>) -> Void) -> URLSessionDataTask {
    let url = Configs.baseURL.appendingPathComponent(path)

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(.dataTask(error)))
        return
      }

      guard let data = data else {
        completion(.failure(.onData))
        return
      }

      guard let response = response as? HTTPURLResponse else {
        completion(.failure(.responseIsNotHTTPURLResponse))
        return
      }

      if expectedStatusCode.contains(response.statusCode) {
        completion(.failure(.unexpectedResponseCode(response.statusCode)))
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
