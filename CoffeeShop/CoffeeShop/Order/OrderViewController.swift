import CoffeeShopAPI
import UIKit

public final class OrderViewController: UIViewController {
  internal var cart = Cart<Product>()
  weak var productListViewController: ProductListViewController?

  @IBOutlet var totalItemLabel: UILabel!
  @IBOutlet var totalPriceLabel: UILabel!
  @IBOutlet var controlView: UIView!

  override public func viewDidLoad() {
    super.viewDidLoad()
    updateControl()
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
  func cart<T>(_: Cart<T>, didUpdate _: [T: UInt]) where T: Hashable {
    updateControl()
  }

  private func updateControl() {
    var totalItem: UInt = 0
    var totalPrice: UInt = 0
    cart.items.forEach { product, count in
      totalItem += count
      totalPrice += product.price * count
    }

    totalItemLabel.text = "\(totalItem)"
    totalPriceLabel.text = "\(toCurrency(number: totalPrice))"

    controlView.alpha = totalItem == 0 ? 0 : 1
  }

  private func toCurrency(number: UInt) -> String {
    let priceFormatter = NumberFormatter()
    priceFormatter.numberStyle = .currency
    priceFormatter.currencySymbol = ""
    priceFormatter.maximumFractionDigits = 0

    let nsNumber = NSNumber(value: number)
    return priceFormatter.string(from: nsNumber) ?? "\(number)"
  }
}
