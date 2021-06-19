import Foundation

public struct Product: Codable {
  let name: String
  let price: Int
  let imageURL: URL

  private enum CodingKeys: String, CodingKey {
    case name
    case price
    case imageURL = "imageUrl"
  }
}
