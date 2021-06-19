@testable import CoffeeShop
import XCTest

final class ProductListViewControllerTests: TestCase {
  var sut: ProductListViewController!

  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "ProductList", bundle: .this)
    let identifier = String(describing: ProductListViewController.self)
    sut = storyboard.instantiateViewController(withIdentifier: identifier) as? ProductListViewController
  }

  func test_viewDidLoad_shouldSetUpViewControllerPresenter() {
    sut.viewDidLoad()

    XCTAssertEqual(sut.interactor.presenter.viewController, sut)
  }

  func testView() {
    sut.view.frame = CGRect(x: 0, y: 0, width: 320, height: 320)

    sut.render(products: [
      .init(name: "Americano", price: 99, imageURL: .placeholder),
      .init(name: "Late", price: 199, imageURL: .placeholder),
    ])

    FBSnapshotVerifyView(sut.view)
  }
}
