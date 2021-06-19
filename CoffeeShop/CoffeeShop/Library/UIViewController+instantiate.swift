import UIKit

public extension UIViewController {
  static func instantiate() -> Self {
    let identifier = String(describing: Self.self)
    let storyboardName = identifier.replacingOccurrences(of: "ViewController", with: "")
    let storyboard = UIStoryboard(name: storyboardName, bundle: .this)
    guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
      fatalError("Could not instantiate \(identifier), from \(storyboardName)")
    }
    return vc
  }
}
