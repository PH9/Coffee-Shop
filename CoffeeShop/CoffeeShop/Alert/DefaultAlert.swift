import UIKit

final class DefaultAlert: UIAlertController {
  static func instantiate(
    title: String? = nil,
    message: String? = nil
  ) -> DefaultAlert {
    let alert = DefaultAlert(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    return alert
  }
}
