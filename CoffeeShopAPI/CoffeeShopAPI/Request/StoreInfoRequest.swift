import Foundation

public struct StoreInfoRequest: Requestable {
  public init() {}

  public func request(completion: @escaping (Result<StoreInfo, RequestError>) -> Void) {
    let url = Configs.baseURL.appendingPathComponent("/storeInfo")

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
        let value = try JSONDecoder().decode(StoreInfo.self, from: data)
        completion(.success(value))
      } catch {
        completion(.failure(.parsing(error)))
      }
    }

    task.resume()
  }
}
