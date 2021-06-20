@testable import CoffeeShop
import XCTest

class StyleTests: XCTestCase {
  func test_rounded() {
    let view = UIView()

    view <~ rounded

    XCTAssertEqual(view.layer.cornerRadius, 3)
  }
}
