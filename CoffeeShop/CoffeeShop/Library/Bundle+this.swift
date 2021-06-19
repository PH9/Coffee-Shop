extension Bundle {
  private final class Token {}
  static let this = Bundle(for: Token.self)
}
