import Foundation

public struct CreateOrder: Requestable {
  public let method: HTTPMethod = .post
  public let path = "/order"
  public let parameters: Order?
  public let expectedStatusCode: ClosedRange<Int> = 201 ... 201
  public typealias ResponseType = Empty

  public init(products: [Product], address: String) {
    parameters = Order(products: products, deliveryAddress: address)
  }
}
