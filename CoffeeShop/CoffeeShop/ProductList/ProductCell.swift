import UIKit

final class ProductCell: UITableViewCell {
  @IBOutlet var productImageView: UIImageView!
  @IBOutlet var productNameLabel: UILabel!
  @IBOutlet var productPriceLabel: UILabel!
  @IBOutlet var itemCountTextField: UITextField!
  @IBOutlet var minusButton: UIButton!
  @IBOutlet var plusButton: UIButton!

  @IBAction func reduceItem(_: Any) {}

  @IBAction func addItem(_: Any) {}
}
