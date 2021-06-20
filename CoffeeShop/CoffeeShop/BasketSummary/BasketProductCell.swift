import UIKit

struct BasketProduct {
  let imageURL: URL
  let name: String
  let price: Int
  let itemCount: Int
}

class BasketProductCell: UITableViewCell {
  @IBOutlet var productImageView: UIImageView!
  @IBOutlet var productNameLabel: UILabel!
  @IBOutlet var productPriceLabel: UILabel!
  @IBOutlet var productCountLabel: UILabel!
  @IBOutlet var totalLabel: UILabel!

  func configureWith(_ value: BasketProduct) {
    productImageView.setImage(with: value.imageURL)
    productNameLabel.text = value.name
    productPriceLabel.text = "\(value.price)"
    productCountLabel.text = "\(value.itemCount)"
    totalLabel.text = "\(value.price * value.itemCount)"
  }
}
