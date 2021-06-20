import CoffeeShopAPI
import UIKit

extension Product: Sellable {}

public final class OrderViewController: UIViewController {
  internal var cart = Cart<Product>()
  weak var productListViewController: ProductListViewController?

  @IBOutlet var controlView: UIView!
  @IBOutlet var gotoBasketSummaryButton: OrderButton!

  override public func viewDidLoad() {
    super.viewDidLoad()
    controlView <~ rounded
    cart.subscribeToUpdate(subscriber: self)
    productListViewController?.cart = cart
  }

  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  deinit {
    cart = Cart<Product>()
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

  @IBAction func gotoBasketSummary(_: Any) {
    let vc = BasketSummaryViewController.instantiate(cart: cart)
    present(vc, animated: true, completion: nil)
  }
}

extension OrderViewController: CartUpdateSubscriber {
  func cart<T>(_: Cart<T>, didUpdate items: [T: UInt]) where T: Hashable {
    gotoBasketSummaryButton.configureWith(items)
  }
}
