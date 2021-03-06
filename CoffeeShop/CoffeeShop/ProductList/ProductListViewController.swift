import CoffeeShopAPI
import UIKit

final class ProductListViewController: UITableViewController {
  let interactor = ProductListInteractor()
  var products: [Product] = []
  weak var basket: Basket<Product>!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.keyboardDismissMode = .onDrag
    interactor.presenter.viewController = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    interactor.getProducts()
  }

  func render(products: [Product]) {
    self.products = products
    tableView.reloadData()
  }

  override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    products.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(ProductCell.self, for: indexPath)
    cell.configureWith((product: products[indexPath.row], basket: basket))
    return cell
  }
}
