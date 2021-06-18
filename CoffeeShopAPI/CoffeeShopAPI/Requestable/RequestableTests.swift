@testable import CoffeeShopAPI
import XCTest

class RequestableTests: XCTestCase {
  let sut = MyRequest()

  func test_defaultValues() {
    XCTAssertEqual(sut.method, .get)
    XCTAssertEqual(sut.expectedStatusCode, 200 ... 299)
  }

  func test_request_withNothingResponse() {
    URLProtocolMock.stub = [sut.url: (nil, nil, nil)]

    let expectation = XCTestExpectation()
    _ = sut.request(urlSession: makeMockSession()) { result in
      defer {
        expectation.fulfill()
      }

      guard case let .failure(error) = result else {
        XCTFail("There is no nothing, should get failure result")
        return
      }

      switch error {
      case .responseIsNotHTTPURLResponse:
        break
      default:
        XCTFail("Should be responseIsNotHTTPURLResponse error")
      }
    }

    wait(for: [expectation], timeout: 1)
  }

  private func makeMockSession() -> URLSession {
    let sessionConfiguration = URLSessionConfiguration.ephemeral
    sessionConfiguration.protocolClasses = [URLProtocolMock.self]
    return URLSession(configuration: sessionConfiguration)
  }
}
