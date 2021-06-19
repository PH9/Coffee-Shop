@testable import CoffeeShop
import XCTest

class ProductListViewControllerTests: XCTestCase {
  var sut: ProductListViewController!

  override func setUp() {
    super.setUp()
    sut = ProductListViewController()
  }

  func test_viewDidLoad_shouldSetUpViewControllerPresenter() {
    sut.viewDidLoad()

    XCTAssertEqual(sut.interactor.presenter.viewController, sut)
  }
}
