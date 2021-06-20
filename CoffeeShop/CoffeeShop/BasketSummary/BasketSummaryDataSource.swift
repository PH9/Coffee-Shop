import CoffeeShopAPI
import UIKit

final class BasketSummaryDataSource: NSObject, UITableViewDataSource {
  private weak var basket: Basket<Product>?

  init(basket: Basket<Product>) {
    self.basket = basket
  }

  public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    basket?.items.count ?? 0
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(BasketProductCell.self, for: indexPath)
    let (product, itemCount) = Array(basket!.items)[indexPath.row]
    cell.configureWith(convertProductToBasketProduct(product: product, itemCount: itemCount))
    return cell
  }

  private func convertProductToBasketProduct(product: Product, itemCount: UInt) -> BasketProduct {
    BasketProduct(imageURL: product.imageURL, name: product.name, price: product.price, itemCount: itemCount)
  }
}
