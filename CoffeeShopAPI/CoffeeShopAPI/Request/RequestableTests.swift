@testable import CoffeeShopAPI
import XCTest

struct MyStruct: Decodable {
  let key: String
}

struct MyRequest: Requestable {
  let path = "/this-path"
  typealias ResponseType = MyStruct
}

class RequestableTests: XCTestCase {
  let sut = MyRequest()

  func test_defaultValues() {
    XCTAssertEqual(sut.method, .get)
    XCTAssertEqual(sut.expectedStatusCode, 200 ... 299)
  }
}
