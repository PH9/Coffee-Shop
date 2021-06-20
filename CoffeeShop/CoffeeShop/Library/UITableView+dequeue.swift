import UIKit.UITableView

extension UITableView {
  func dequeue<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
    let identifier = String(describing: cellType)
    guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
      fatalError("Could not dequeue \(identifier) for \(indexPath)")
    }

    return cell
  }
}
