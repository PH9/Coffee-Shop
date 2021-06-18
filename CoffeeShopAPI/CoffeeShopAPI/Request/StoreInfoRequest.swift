import Foundation

public struct StoreInfoRequest: Requestable {
  public let path = "/storeInfo"
  public typealias ResponseType = StoreInfo
  public init() {}
}
