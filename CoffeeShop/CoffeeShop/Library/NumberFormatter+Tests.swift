@testable import CoffeeShop
import XCTest

class NumberFormatterTests: XCTestCase {
  func test_currency() {
    let sut = NumberFormatter.currency

    XCTAssertEqual(sut.numberStyle, .currency)
    XCTAssertEqual(sut.currencySymbol, "")
    XCTAssertEqual(sut.maximumFractionDigits, 0)
  }
}
