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
        XCTFail("Should be responseIsNotHTTPURLResponse, but got \(error)")
      }
    }

    wait(for: [expectation], timeout: 1)
  }

  func test_request_withErrorResponse_shouldGetErrorResult() {
    let error = NSError(domain: "com.ph9", code: -99, userInfo: nil)
    URLProtocolMock.stub = [sut.url: (nil, nil, error)]

    let expectation = XCTestExpectation()
    _ = sut.request(urlSession: makeMockSession()) { result in
      defer {
        expectation.fulfill()
      }

      guard case let .failure(responseError) = result else {
        XCTFail("There is no nothing, should get failure result")
        return
      }

      switch responseError {
      case let .dataTask(responseError):
        let responseError = responseError as NSError
        XCTAssertEqual(responseError.code, error.code)
        XCTAssertEqual(responseError.domain, error.domain)
      default:
        XCTFail("Should be responseIsNotHTTPURLResponse, but got \(responseError)")
      }
    }

    wait(for: [expectation], timeout: 1)
  }

  func test_requestWithUnExpectedStatusCode_shouldGetError() {
    let response = HTTPURLResponse(url: sut.url, statusCode: 400, httpVersion: nil, headerFields: nil)
    URLProtocolMock.stub = [sut.url: (nil, response, nil)]

    let expectation = XCTestExpectation()
    _ = sut.request(urlSession: makeMockSession()) { result in
      defer {
        expectation.fulfill()
      }

      guard case let .failure(responseError) = result else {
        XCTFail("There is no nothing, should get failure result")
        return
      }

      switch responseError {
      case let .unexpectedResponseCode(statusCode):
        XCTAssertEqual(statusCode, 400)
      default:
        XCTFail("Should be onData, but got \(responseError)")
      }
    }

    wait(for: [expectation], timeout: 1)
  }

  func test_requestWithNotParsableData_shouldGotError() {
    let response = HTTPURLResponse(url: sut.url, statusCode: 200, httpVersion: nil, headerFields: nil)
    URLProtocolMock.stub = [sut.url: (nil, response, nil)]

    let expectation = XCTestExpectation()
    _ = sut.request(urlSession: makeMockSession()) { result in
      defer {
        expectation.fulfill()
      }

      guard case let .failure(responseError) = result else {
        XCTFail("There is no nothing, should get failure result")
        return
      }

      switch responseError {
      case let .parsing(error):
        XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
      default:
        XCTFail("Should be onData, but got \(responseError)")
      }
    }

    wait(for: [expectation], timeout: 1)
  }

  func test_allCorrect_shouldReturnResponse() throws {
    let response = HTTPURLResponse(url: sut.url, statusCode: 200, httpVersion: nil, headerFields: nil)
    let myResponse = MyResponse(key: "value")
    let myResponseData = try JSONEncoder().encode(myResponse)
    URLProtocolMock.stub = [sut.url: (myResponseData, response, nil)]

    let expectation = XCTestExpectation()
    _ = sut.request(urlSession: makeMockSession()) { result in
      defer {
        expectation.fulfill()
      }

      guard case let .success(responseResponse) = result else {
        XCTFail("There is no nothing, should get failure result")
        return
      }

      XCTAssertEqual(responseResponse, myResponse)
    }

    wait(for: [expectation], timeout: 1)
  }

  private func makeMockSession() -> URLSession {
    let sessionConfiguration = URLSessionConfiguration.ephemeral
    sessionConfiguration.protocolClasses = [URLProtocolMock.self]
    return URLSession(configuration: sessionConfiguration)
  }
}
