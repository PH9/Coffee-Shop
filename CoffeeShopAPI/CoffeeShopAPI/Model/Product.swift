import Foundation

public struct Product: Codable {
  public let name: String
  public let price: Int
  public let imageURL: URL

  private enum CodingKeys: String, CodingKey {
    case name
    case price
    case imageURL = "imageUrl"
  }
}
