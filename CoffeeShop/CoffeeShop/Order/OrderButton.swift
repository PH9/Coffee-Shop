import UIKit.UIControl

@IBDesignable
class OrderButton: UIButton {
  let totalItemCountLabel = UILabel()
  let totalPriceLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }

  private func initialize() {
    self <~ button
    setTitle("Checkout", for: .normal)
    setupTotalItemCount()
    setupTotalPriceLabel()
  }

  func configureWith<T: Sellable>(_ value: [T: UInt]) {
    var totalItem: UInt = 0
    var totalPrice: UInt = 0
    value.forEach { item, count in
      totalItem += count
      totalPrice += item.price * count
    }

    totalItemCountLabel.text = "\(totalItem)"
    totalPriceLabel.text = "\(totalPrice.toCurrency())"
  }

  private func setupTotalItemCount() {
    totalItemCountLabel.text = "0"
    totalItemCountLabel.textColor = .white
    addSubview(totalItemCountLabel)
    totalItemCountLabel.translatesAutoresizingMaskIntoConstraints = false
    totalItemCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    totalItemCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    bringSubviewToFront(totalItemCountLabel)
  }

  private func setupTotalPriceLabel() {
    totalPriceLabel.text = "0"
    totalPriceLabel.textColor = .white
    totalPriceLabel.textAlignment = .right
    addSubview(totalPriceLabel)
    totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
    totalPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    totalPriceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    bringSubviewToFront(totalPriceLabel)
  }
}
