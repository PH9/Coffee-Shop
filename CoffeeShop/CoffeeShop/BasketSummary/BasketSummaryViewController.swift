import CoffeeShopAPI
import UIKit

public class BasketSummaryViewController: UITableViewController {
  private weak var basket: Basket<Product>?

  static func instantiate(basket: Basket<Product>) -> Self {
    let vc = instantiate()
    vc.basket = basket
    return vc
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    title = "Checkout"
    navigationController?.setNavigationBarHidden(false, animated: true)
    tableView.estimatedRowHeight = 105
    tableView.rowHeight = UITableView.automaticDimension
  }

  override public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    basket?.items.count ?? 0
  }

  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(BasketProductCell.self, for: indexPath)
    return cell
  }
}
