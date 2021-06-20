@testable import CoffeeShop
import CoffeeShopAPI
import XCTest

class BasketSummaryViewControllerTests: TestCase {
  var sut: BasketSummaryViewController!

  override func setUp() {
    super.setUp()
    sut = BasketSummaryViewController.instantiate(items: makeItems())
    sut.view.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
  }

  func testView() {
    FBSnapshotVerifyView(sut.view)
  }

  private func makeItems() -> [(Product, UInt)] {
    [
      (Product(name: "Americano", price: 50, imageURL: .placeholder), 2),
      (Product(name: "Espresso", price: 40, imageURL: .placeholder), 3),
      (Product(name: "Mineral", price: 120, imageURL: .placeholder), 1),
    ]
  }
}
