@testable import CoffeeShop
import CoffeeShopAPI
import XCTest

class BasketSummaryViewControllerTests: TestCase {
  var sut: BasketSummaryViewController!

  override func setUp() {
    super.setUp()
    let basket: Basket<Product> = Basket()
    basket.add(item: Product(name: "Americano", price: 50, imageURL: .placeholder))
    basket.add(item: Product(name: "Espresso", price: 40, imageURL: .placeholder))
    basket.add(item: Product(name: "Mineral", price: 120, imageURL: .placeholder))
    sut = BasketSummaryViewController.instantiate(basket: basket)
    sut.view.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
  }

  func testView() {}
}
