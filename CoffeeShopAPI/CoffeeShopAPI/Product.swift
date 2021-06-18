import Foundation

public struct Product: Decodable {
  let name: String
  let price: Int
  let imageURL: URL
}
