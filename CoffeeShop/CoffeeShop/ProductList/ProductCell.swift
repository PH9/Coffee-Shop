import CoffeeShopAPI
import UIKit

final class ProductCell: UITableViewCell {
  @IBOutlet var productImageView: UIImageView!
  @IBOutlet var productNameLabel: UILabel!
  @IBOutlet var productPriceLabel: UILabel!
  @IBOutlet var itemCountTextField: UITextField!
  @IBOutlet var minusButton: UIButton!
  @IBOutlet var plusButton: UIButton!

  func configureWith(_ value: Product) {
    productNameLabel.text = value.name
    productPriceLabel.text = "\(value.price)"
  }

  @IBAction func reduceItem(_: Any) {}
  @IBAction func addItem(_: Any) {}
}
