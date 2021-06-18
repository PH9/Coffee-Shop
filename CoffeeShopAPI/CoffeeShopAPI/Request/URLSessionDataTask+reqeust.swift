import Foundation

public protocol Cancellable {
  func cancel()
}

extension URLSessionDataTask: Cancellable {}
