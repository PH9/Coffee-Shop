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
      switch result {
      case let .failure(error):
        switch error {
        case .responseIsNotHTTPURLResponse:
          break
        default:
          XCTFail("Should be noResponse error")
        }
      default:
        XCTFail("There is no nothing, should get failure result")
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1)
  }

  private func makeMockSession() -> URLSession {
    let sessionConfiguration = URLSessionConfiguration.ephemeral
    sessionConfiguration.protocolClasses = [URLProtocolMock.self]
    return URLSession(configuration: sessionConfiguration)
  }
}
