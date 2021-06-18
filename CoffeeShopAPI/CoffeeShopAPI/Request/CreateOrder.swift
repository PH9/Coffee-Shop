import Foundation

public struct CreateOrder: Requestable {
  public let path = "/order"
  public typealias ResponseType = EmptyResponse
  public let expectedStatusCode: ClosedRange<Int> = 201 ... 201

  let product: Product
  let address: String

  public init(product: Product, address: String) {
    self.product = product
    self.address = address
  }
}
