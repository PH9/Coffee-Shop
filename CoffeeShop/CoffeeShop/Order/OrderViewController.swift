import CoffeeShopAPI
import UIKit

extension Product: Sellable {}

public final class OrderViewController: UIViewController {
  internal var basket = Basket<Product>()
  weak var storeInfoViewController: StoreInfoViewController?
  weak var productListViewController: ProductListViewController?

  @IBOutlet var controlView: UIView!
  @IBOutlet var gotoBasketSummaryButton: OrderButton!

  override public func viewDidLoad() {
    super.viewDidLoad()
    title = "Order"
    controlView <~ rounded
    basket.subscribeToUpdate(subscriber: self)
    productListViewController?.basket = basket
  }

  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  deinit {
    basket = Basket<Product>()
  }

  override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    switch segue.destination {
    case let vc as ProductListViewController:
      productListViewController = vc
    case let vc as StoreInfoViewController:
      storeInfoViewController = vc
    default:
      break
    }

    addChild(segue.destination)
  }

  @IBAction func gotoBasketSummary(_: Any) {
    guard let storeInfo = storeInfoViewController?.storeInfo else {
      return
    }

    let vc = BasketSummaryViewController.instantiate(items: Array(basket.items), storeInfo: storeInfo)
    present(vc, animated: true, completion: nil)
  }
}

extension OrderViewController: BasketUpdateSubscriber {
  func basket<T>(_: Basket<T>, didUpdate items: [T: UInt]) where T: Hashable {
    gotoBasketSummaryButton.configureWith(items)
  }
}
