import UIKit

public final class OrderViewController: UIViewController {
  public static func instantiate() -> Self {
    let storyboardName = "Order"
    let storyboard = UIStoryboard(name: storyboardName, bundle: .this)
    let identifier = String(describing: Self.self)
    guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
      fatalError("Could not instantiate \(identifier), from \(storyboardName)")
    }
    return vc
  }
}
