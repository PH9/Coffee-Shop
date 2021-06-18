import Foundation

public enum StoreInfoRequest {
  public static func request(completion: @escaping (Result<StoreInfo, RequestError>) -> Void) {
    let url = URL(string: "https://virtserver.swaggerhub.com/m-tul/opn-mobile-challenge-api/1.0.0/storeInfo")!

    let task = URLSession.shared.dataTask(with: url) { data, _, _ in
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
