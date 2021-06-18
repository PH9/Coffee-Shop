public struct EmptyResponse: Decodable {}

public protocol Requestable {
  associatedtype ResponseType: Decodable
  func request(completion: @escaping (Result<ResponseType, RequestError>) -> Void)
}
