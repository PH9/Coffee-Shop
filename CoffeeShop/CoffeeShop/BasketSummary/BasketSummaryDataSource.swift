import CoffeeShopAPI
import UIKit

final class BasketSummaryDataSource: NSObject, UITableViewDataSource {
  let items: [(Product, UInt)]

  init(items: [(Product, UInt)]) {
    self.items = items
  }

  public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    items.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(BasketProductCell.self, for: indexPath)
    let (product, itemCount) = items[indexPath.row]
    cell.configureWith(convertProductToBasketProduct(product: product, itemCount: itemCount))
    return cell
  }

  private func convertProductToBasketProduct(product: Product, itemCount: UInt) -> BasketProduct {
    BasketProduct(imageURL: product.imageURL, name: product.name, price: product.price, itemCount: itemCount)
  }
}
