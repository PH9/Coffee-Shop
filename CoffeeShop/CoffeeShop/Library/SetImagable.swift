import UIKit

public enum CoffeeShopConfigurator {
  public static func setSetImageProvider(_ imageProvider: ImageSetterProvider) {
    Provider.imageSetter = imageProvider
  }
}

public protocol ImageSetterProvider {
  func setImage(from url: URL, to imageView: UIImageView)
}

enum Provider {
  fileprivate(set) static var imageSetter: ImageSetterProvider?
}

extension UIImageView {
  func setImage(with url: URL) {
    Provider.imageSetter?.setImage(from: url, to: self)
  }
}
