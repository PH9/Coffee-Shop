import CoffeeShopAPI
import UIKit

public class BasketSummaryViewController: UITableViewController {
  var dataSource: BasketSummaryDataSource!

  static func instantiate(items: [(Product, UInt)]) -> Self {
    let vc = instantiate()
    vc.dataSource = BasketSummaryDataSource(items: items)
    return vc
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    title = "Checkout"
    tableView.dataSource = dataSource
    navigationController?.setNavigationBarHidden(false, animated: true)
    tableView.estimatedRowHeight = 105
    tableView.rowHeight = UITableView.automaticDimension
  }
}
