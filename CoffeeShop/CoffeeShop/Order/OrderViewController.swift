import CoffeeShopAPI
import UIKit

public final class OrderViewController: UIViewController {
  internal var cart = Cart<Product>()
  weak var productListViewController: ProductListViewController?

  @IBOutlet var totalPriceLabel: UILabel!

  override public func viewDidLoad() {
    super.viewDidLoad()
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
}

extension OrderViewController: CartUpdateSubscriber {
  func cart<T>(_ cart: Cart<T>, didUpdate _: [T: Int]) where T: Hashable {
    guard let cart = cart as? Cart<Product> else {
      return
    }

    let totalPrice = cart.items.reduce(0) { result, value in
      let (product, count) = value
      return result + product.price * count
    }

    totalPriceLabel.text = "\(totalPrice).-"
  }
}
