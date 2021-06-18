import Foundation

class URLProtocolMock: URLProtocol {
  static var stub: [URL?: (data: Data?, response: HTTPURLResponse?, error: Error?)] = [:]

  override class func canInit(with _: URLRequest) -> Bool {
    true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }

  override func startLoading() {
    defer {
      client?.urlProtocolDidFinishLoading(self)
    }

    guard let url = request.url,
          let (data, response, error) = URLProtocolMock.stub[url]
    else {
      return
    }

    if let response = response {
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }

    if let data = data {
      client?.urlProtocol(self, didLoad: data)
    }

    if let error = error {
      client?.urlProtocol(self, didFailWithError: error)
    }
  }

  override func stopLoading() {}
}
