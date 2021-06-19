import Foundation

public struct Product: Codable {
  public let name: String
  public let price: Int
  public let imageURL: URL

  public init(name: String, price: Int, imageURL: URL) {
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
