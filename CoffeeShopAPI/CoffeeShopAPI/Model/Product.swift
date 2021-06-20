import Foundation

public struct Product: Codable, Hashable {
  public let name: String
  public let price: UInt
  public let imageURL: URL

  public init(name: String, price: UInt, imageURL: URL) {
    self.name = name
    self.price = price
    self.imageURL = imageURL
  }

  private enum CodingKeys: String, CodingKey {
    case name
    case price
    case imageURL = "imageUrl"
  }
}
