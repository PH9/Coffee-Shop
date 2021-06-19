import CoffeeShopAPI
import UIKit

public final class OrderViewController: UIViewController {
  private var cart = Cart<Product>()
  weak var productListViewController: ProductListViewController?

  override public func viewDidLoad() {
    super.viewDidLoad()
    productListViewController?.cart = cart
  }

  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    switch segue.destination {
    case let vc as ProductListViewController:
      productListViewController = vc
    default:
      break
    }

    addChild(segue.destination)
  }
}
