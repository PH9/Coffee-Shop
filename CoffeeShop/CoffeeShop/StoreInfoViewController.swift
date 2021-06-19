import UIKit

final class StoreInfoViewController: UIViewController {
  @IBOutlet var storeNameLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var workHourLabel: UILabel!

  static func instantiate() -> StoreInfoViewController {
    let storyboardName = "StoreInfo"
    let storyboard = UIStoryboard(name: storyboardName, bundle: .this)
    let identifier = String(describing: Self.self)
    guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
      fatalError("Could not instantiate \(identifier), from \(storyboardName)")
    }
    return vc
  }
}
