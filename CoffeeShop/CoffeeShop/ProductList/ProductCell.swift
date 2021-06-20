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
  private weak var basket: Basket<Product>!

  override func awakeFromNib() {
    super.awakeFromNib()
    productImageView <~ rounded
    itemCountTextField.delegate = self
  }

  func configureWith(_ value: (product: Product, basket: Basket<Product>)) {
    product = value.product
    basket = value.basket
    productImageView.setImage(with: product.imageURL)
    productNameLabel.text = product.name
    productPriceLabel.text = "\(product.price)"
    itemCountTextField.text = "\(basket.items[product] ?? 0)"
  }

  @IBAction func reduceItem(_ sender: UITextField) {
    _ = textFieldShouldReturn(sender)
    itemCountTextField.text = "\(basket.reduce(item: product))"
  }

  @IBAction func addItem(_ sender: UITextField) {
    _ = textFieldShouldReturn(sender)
    itemCountTextField.text = "\(basket.add(item: product))"
  }
}

extension ProductCell: UITextFieldDelegate {
  func textFieldShouldReturn(_: UITextField) -> Bool {
    guard let count = UInt(itemCountTextField.text!) else {
      return true
    }

    itemCountTextField.text = "\(basket.set(item: product, count: count))"
    endEditing(false)
    return true
  }
}
