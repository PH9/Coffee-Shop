import UIKit

struct BasketProduct {
  let imageURL: URL
  let name: String
  let price: UInt
  let itemCount: UInt
}

class BasketProductCell: UITableViewCell {
  @IBOutlet var productImageView: UIImageView!
  @IBOutlet var productNameLabel: UILabel!
  @IBOutlet var productPriceLabel: UILabel!
  @IBOutlet var productCountLabel: UILabel!
  @IBOutlet var totalLabel: UILabel!
  @IBOutlet var productStack: UIStackView!
  @IBOutlet var priceStack: UIStackView!

  override func awakeFromNib() {
    super.awakeFromNib()
    update()
  }

  func configureWith(_ value: BasketProduct) {
    productImageView.setImage(with: value.imageURL)
    productNameLabel.text = value.name
    productPriceLabel.text = "\(value.price)"
    productCountLabel.text = "x\(value.itemCount)"
    totalLabel.text = "\(value.price * value.itemCount)"
  }

  private func update() {
    if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
      productStack.axis = .vertical
      priceStack.axis = .vertical
      productCountLabel.textAlignment = .right
    } else {
      productStack.axis = .horizontal
      priceStack.axis = .horizontal
      productCountLabel.textAlignment = .left
    }
  }
}
