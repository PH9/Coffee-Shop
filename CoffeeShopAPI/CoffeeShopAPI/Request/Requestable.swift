import Foundation

public struct EmptyResponse: Decodable {}

public protocol Requestable {
  associatedtype ResponseType: Decodable
  var path: String { get }
  func request(completion: @escaping (Result<ResponseType, RequestError>) -> Void) -> URLSessionDataTask
}
