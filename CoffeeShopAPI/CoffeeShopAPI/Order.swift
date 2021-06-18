public struct Order: Encodable {
  let product: Product
  let deliveryAddress: String

  public init(product: Product, deliveryAddress: String) {
    self.product = product
    self.deliveryAddress = deliveryAddress
  }

  private enum CodingKeys: String, CodingKey {
    case product
    case deliveryAddress = "delivery_address"
  }
}
