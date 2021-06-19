import UIKit

final class ProductListViewController: UITableViewController {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
      fatalError("Could not dequeue cell")
    }

    return cell
  }
}
