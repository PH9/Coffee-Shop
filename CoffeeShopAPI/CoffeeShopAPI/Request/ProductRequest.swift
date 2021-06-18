import Foundation

public struct ProductRequest: Requestable {
  public init() {}

  public func request(completion: @escaping (Result<[Product], RequestError>) -> Void) -> URLSessionDataTask {
    let url = Configs.baseURL.appendingPathComponent("/products")

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
        let value = try JSONDecoder().decode([Product].self, from: data)
        completion(.success(value))
      } catch {
        completion(.failure(.parsing(error)))
      }
    }

    task.resume()
    return task
  }
}
