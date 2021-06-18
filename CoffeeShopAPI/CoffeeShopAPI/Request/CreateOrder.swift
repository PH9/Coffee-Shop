import Foundation

public struct CreateOrder {
  let product: Product
  let address: String

  public init(product: Product, address: String) {
    self.product = product
    self.address = address
  }

  public func request(completion: @escaping (Result<Void, RequestError>) -> Void) {
    let url = URL(string: "https://virtserver.swaggerhub.com/m-tul/opn-mobile-challenge-api/1.0.0/order")!
    let request = URLRequest(url: url)

    let task = URLSession.shared.dataTask(with: request) { _, response, error in
      if let error = error {
        completion(.failure(.dataTask(error)))
        return
      }

      guard let response = response else {
        completion(.failure(.noResponse))
        return
      }

      guard let response = response as? HTTPURLResponse else {
        completion(.failure(.responseIsNotHTTPURLResponse))
        return
      }

      if response.statusCode != 201 {
        completion(.failure(.unexpectedResponseCode(response.statusCode)))
        return
      }

      completion(.success(()))
    }

    task.resume()
  }
}
