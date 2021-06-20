@testable import CoffeeShop
import XCTest

final class NumberFormatterSpy: NumberFormatter {
  var stringCalledCount = 0
  var stringNumber: NSNumber?
  override func string(from number: NSNumber) -> String? {
    stringCalledCount += 1
    stringNumber = number
    return nil
  }
}

final class UIntFormatterTests: XCTestCase {
  func test_shouldUseStringFromNumberFormatter() {
    let sut: UInt = 0
    let formatterSpy = NumberFormatterSpy()

    _ = sut.toCurrency(formatter: formatterSpy)

    XCTAssertEqual(formatterSpy.stringCalledCount, 1)
    XCTAssertEqual(formatterSpy.stringNumber, 0)
  }
}
