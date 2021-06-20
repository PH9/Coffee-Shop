import CoffeeShopAPI
import UIKit

public class BasketSummaryViewController: UITableViewController {
  @IBOutlet var addressTextView: UITextView!

  var dataSource: BasketSummaryDataSource!
  var storeInfo: StoreInfo!

  static func instantiate(items: [(Product, UInt)], storeInfo: StoreInfo) -> Self {
    let vc = instantiate()
    vc.dataSource = BasketSummaryDataSource(items: items)
    vc.storeInfo = storeInfo
    return vc
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    addressTextView.layer.borderWidth = 1
    addressTextView.layer.cornerRadius = 3
    addressTextView.layer.borderColor = UIColor.systemGray.cgColor

    title = "Checkout"
    tableView.dataSource = dataSource
    navigationController?.setNavigationBarHidden(false, animated: true)
    tableView.estimatedRowHeight = 105
    tableView.rowHeight = UITableView.automaticDimension
  }

  @IBAction func order(_: Any) {
    var products: [Product] = []
    dataSource.items.forEach { product, count in
      for _ in 0 ..< count {
        products.append(product)
      }
    }

    CreateOrder(products: products, address: addressTextView.text).request { result in
      switch result {
      case .success:
        print("success")
      case let .failure(error):
        print(error)
      }
    }
  }
}
