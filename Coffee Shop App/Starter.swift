import CoffeeShop
import UIKit

enum Starter {
  static func start(from window: UIWindow) {
    let viewController = OrderViewController.instantiate()
    let navigation = UINavigationController(rootViewController: viewController)
    window.rootViewController = navigation

    window.makeKeyAndVisible()
  }
}
