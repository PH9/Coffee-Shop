import Foundation

public protocol Requestable {
  var method: HTTPMethod { get }
  var path: String { get }
  var expectedStatusCode: ClosedRange<Int> { get }
  associatedtype ResponseType: Decodable
  func request(urlSession: URLSession, completion: @escaping (Result<ResponseType, RequestError>) -> Void)
    -> Cancellable
}

public extension Requestable {
  var method: HTTPMethod {
    .get
  }

  var expectedStatusCode: ClosedRange<Int> {
    200 ... 299
  }

  func request(
    urlSession: URLSession = .shared,
    completion: @escaping (Result<ResponseType, RequestError>) -> Void
  ) -> Cancellable {
    let url = Configs.baseURL.appendingPathComponent(path)
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue

    let task = urlSession.dataTask(with: request) { data, response, error in
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
