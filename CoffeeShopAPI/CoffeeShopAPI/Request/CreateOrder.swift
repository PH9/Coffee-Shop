import Foundation

public struct CreateOrder: Requestable {
  public let method: HTTPMethod = .post
  public let path = "/order"
  public let expectedStatusCode: ClosedRange<Int> = 201 ... 201
  public typealias ResponseType = EmptyResponse

  let product: Product
  let address: String

  public init(product: Product, address: String) {
    self.product = product
    self.address = address
  }
}
