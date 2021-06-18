import Foundation

public struct ProductRequest: Requestable {
  public let path = "/products"
  public typealias ResponseType = [Product]
  public init() {}
}
