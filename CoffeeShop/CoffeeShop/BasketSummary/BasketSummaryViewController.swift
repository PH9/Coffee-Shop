import UIKit

public class BasketSummaryViewController: UITableViewController {
  override public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    5
  }

  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BasketProductCell", for: indexPath)
    return cell
  }
}
