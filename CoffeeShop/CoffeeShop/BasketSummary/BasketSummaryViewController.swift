import UIKit

public class BasketSummaryViewController: UITableViewController {
  override public func viewDidLoad() {
    super.viewDidLoad()
    tableView.estimatedRowHeight = 105
    tableView.rowHeight = UITableView.automaticDimension
  }

  override public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    5
  }

  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BasketProductCell", for: indexPath)
    return cell
  }
}
