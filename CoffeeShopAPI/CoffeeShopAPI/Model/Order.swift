public struct Order: Encodable {
  let products: [Product]
  let deliveryAddress: String

  public init(products: [Product], deliveryAddress: String) {
    self.products = products
    self.deliveryAddress = deliveryAddress
  }

  private enum CodingKeys: String, CodingKey {
    case products
    case deliveryAddress = "delivery_address"
  }
}
