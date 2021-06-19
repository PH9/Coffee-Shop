import CoffeeShopAPI
import UIKit

final class ProductCell: UITableViewCell {
  @IBOutlet var productImageView: UIImageView!
  @IBOutlet var productNameLabel: UILabel!
  @IBOutlet var productPriceLabel: UILabel!
  @IBOutlet var itemCountTextField: UITextField!
  @IBOutlet var minusButton: UIButton!
  @IBOutlet var plusButton: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()
    productImageView.layer.cornerRadius = 3
  }

  func configureWith(_ value: Product) {
    productImageView.setImage(with: value.imageURL)
    productNameLabel.text = value.name
    productPriceLabel.text = "\(value.price)"
  }

  @IBAction func reduceItem(_: Any) {}
  @IBAction func addItem(_: Any) {}
}
