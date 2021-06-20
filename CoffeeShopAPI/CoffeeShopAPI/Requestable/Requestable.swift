import Foundation

public protocol Requestable {
  var method: HTTPMethod { get }
  var url: URL { get }
  var path: String { get }
  associatedtype ParameterType: Encodable
  var parameters: ParameterType? { get }
  var expectedStatusCode: ClosedRange<Int> { get }
  associatedtype ResponseType: Decodable
  @discardableResult func request(
    urlSession: URLSession,
    completion: @escaping (Result<ResponseType, RequestError>) -> Void
  )
    -> Cancellable
}

public extension Requestable {
  var method: HTTPMethod {
    .get
  }

  var parameters: Empty? {
    nil
  }

  var url: URL {
    Configs.baseURL.appendingPathComponent(path)
  }

  var expectedStatusCode: ClosedRange<Int> {
    200 ... 299
  }

  @discardableResult func request(
    urlSession: URLSession = .shared,
    completion: @escaping (Result<ResponseType, RequestError>) -> Void
  ) -> Cancellable {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    if method == .post, let parameters = parameters {
      request.httpBody = try? JSONEncoder().encode(parameters)
    }

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

      guard expectedStatusCode.contains(response.statusCode) else {
        completion(.failure(.unexpectedResponseCode(response.statusCode)))
        return
      }

      if ResponseType.self == Empty.self {
        // swiftlint:disable force_cast
        completion(.success(Empty() as! Self.ResponseType))
        // swiftlint:enable force_cast
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
