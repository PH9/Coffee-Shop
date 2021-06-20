public enum CoffeeShopConfigurator {
  public static func setSetImageProvider(_ imageProvider: ImageSetterProvider) {
    Provider.imageSetter = imageProvider
  }
}

enum Provider {
  fileprivate(set) static var imageSetter: ImageSetterProvider?
}
