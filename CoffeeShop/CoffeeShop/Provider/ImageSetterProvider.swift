import UIKit

public protocol ImageSetterProvider {
  func setImage(from url: URL, to imageView: UIImageView)
}

extension UIImageView {
  func setImage(with url: URL) {
    Provider.imageSetter?.setImage(from: url, to: self)
  }
}
