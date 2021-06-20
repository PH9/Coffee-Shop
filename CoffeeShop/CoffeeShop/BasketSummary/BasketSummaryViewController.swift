import CoffeeShopAPI
import UIKit

public class BasketSummaryViewController: UITableViewController {
  private weak var cart: Cart<Product>?

  static func instantiate(cart: Cart<Product>) -> Self {
    let vc = instantiate()
    vc.cart = cart
    return vc
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    tableView.estimatedRowHeight = 105
    tableView.rowHeight = UITableView.automaticDimension
  }

  override public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    cart?.items.count ?? 0
  }

  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BasketProductCell", for: indexPath)
    return cell
  }
}
