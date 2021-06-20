extension UInt {
  func toCurrency() -> String {
    let number = NSNumber(value: self)
    return NumberFormatter.currency.string(from: number) ?? "\(self)"
  }
}
