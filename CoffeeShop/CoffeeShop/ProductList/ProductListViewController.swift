import CoffeeShopAPI
import UIKit

final class ProductListViewController: UITableViewController {
  let interactor = ProductListInteractor()
  var products: [Product] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    interactor.presenter.viewController = self
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
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
      fatalError("Could not dequeue cell")
    }

    cell.configureWith(products[indexPath.row])

    return cell
  }
}
