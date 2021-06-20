@testable import CoffeeShop
import CoffeeShopAPI
import XCTest

final class OrderButtonSpy: OrderButton {
  var configureWithCalledCount = 0
  var configureWithValue: [Product: UInt]?
  override func configureWith<T>(_ value: [T: UInt]) where T: Hashable {
    configureWithCalledCount += 1
    configureWithValue = value as? [Product: UInt]
  }
}

final class OrderViewControllerTests: XCTestCase {
  var sut: OrderViewController!

  override func setUp() {
    super.setUp()
    sut = OrderViewController.instantiate()
  }

  func test_gotoBasketSummary_shouldPresent() {}

  func test_whenUpdateBasket_shouldConfigTheOrderButton() {
    let buttonSpy = OrderButtonSpy()
    sut.gotoBasketSummaryButton = buttonSpy
    let items: [Product: UInt] = [
      Product(name: "", price: 0, imageURL: .placeholder): 1,
    ]

    sut.basket(sut.basket, didUpdate: items)

    XCTAssertEqual(buttonSpy.configureWithCalledCount, 1)
    XCTAssertEqual(buttonSpy.configureWithValue, items)
  }
}
