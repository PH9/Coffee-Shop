import CoffeeShopAPI
import UIKit

final class ProductCell: UITableViewCell {
  @IBOutlet var productImageView: UIImageView!
  @IBOutlet var productNameLabel: UILabel!
  @IBOutlet var productPriceLabel: UILabel!
  @IBOutlet var itemCountTextField: UITextField!
  @IBOutlet var minusButton: UIButton!
  @IBOutlet var plusButton: UIButton!

  private var product: Product!
  private weak var cart: Cart!

  override func awakeFromNib() {
    super.awakeFromNib()
    productImageView.layer.cornerRadius = 3
    itemCountTextField.delegate = self
  }

  func configureWith(_ value: (product: Product, cart: Cart)) {
    product = value.product
    cart = value.cart
    productImageView.setImage(with: product.imageURL)
    productNameLabel.text = product.name
    productPriceLabel.text = "\(product.price)"
  }

  @IBAction func reduceItem(_: Any) {
    defer {
      itemCountTextField.text = "\(cart.items[product]!)"
    }

    guard var count = cart.items[product] else {
      cart.items[product] = 0
      return
    }

    count -= 1
    count = count < 0 ? 0 : count
    cart.items[product] = count
  }

  @IBAction func addItem(_: Any) {
    defer {
      itemCountTextField.text = "\(cart.items[product]!)"
    }

    guard var count = cart.items[product] else {
      cart.items[product] = 1
      return
    }

    count += 1
    cart.items[product] = count
  }
}

extension ProductCell: UITextFieldDelegate {
  func textFieldShouldReturn(_: UITextField) -> Bool {
    endEditing(false)
    return true
  }
}
