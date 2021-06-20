@testable import CoffeeShop
import XCTest

final class OrderButtonTests: TestCase {
  var sut: OrderButton!

  override func setUp() {
    super.setUp()
    sut = OrderButton(frame: CGRect(x: 0, y: 0, width: 288, height: 44))
  }

  func test() {
    let value: [SellableItem: UInt] = [
      SellableItem(price: 0): 1,
      SellableItem(price: 99): 2,
      SellableItem(price: 1000): 3,
    ]

    sut.configureWith(value)

    FBSnapshotVerifyView(sut)
  }
}
