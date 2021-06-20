import Foundation

public struct CreateOrder: Requestable {
  public let method: HTTPMethod = .post
  public let path = "/order"
  public let expectedStatusCode: ClosedRange<Int> = 201 ... 201
  public typealias ResponseType = EmptyResponse

  let products: [Product]
  let address: String

  public init(products: [Product], address: String) {
    self.products = products
    self.address = address
  }
}
