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
  private weak var cart: Cart<Product>!

  override func awakeFromNib() {
    super.awakeFromNib()
    productImageView.layer.cornerRadius = 3
    itemCountTextField.delegate = self
  }

  func configureWith(_ value: (product: Product, cart: Cart<Product>)) {
    product = value.product
    cart = value.cart
    productImageView.setImage(with: product.imageURL)
    productNameLabel.text = product.name
    productPriceLabel.text = "\(product.price)"
  }

  @IBAction func reduceItem(_ sender: UITextField) {
    _ = textFieldShouldReturn(sender)
    itemCountTextField.text = "\(cart.reduce(item: product))"
  }

  @IBAction func addItem(_ sender: UITextField) {
    _ = textFieldShouldReturn(sender)
    itemCountTextField.text = "\(cart.add(item: product))"
  }
}

extension ProductCell: UITextFieldDelegate {
  func textFieldShouldReturn(_: UITextField) -> Bool {
    let count = UInt(itemCountTextField.text!)
    itemCountTextField.text = "\(cart.set(item: product, count: count))"
    endEditing(false)
    return true
  }
}
