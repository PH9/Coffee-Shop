extension UInt {
  func toCurrency(formatter: NumberFormatter = .currency) -> String {
    let number = NSNumber(value: self)
    return formatter.string(from: number) ?? "\(self)"
  }
}
