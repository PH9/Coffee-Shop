import CoffeeShop
import Kingfisher
import UIKit

final class ImageProvider: ImageSetterProvider {
  static func setup() {
    CoffeeShopConfigurator.setSetImageProvider(ImageProvider())
  }

  func setImage(from url: URL, to imageView: UIImageView) {
    imageView.kf.setImage(with: url)
  }
}
