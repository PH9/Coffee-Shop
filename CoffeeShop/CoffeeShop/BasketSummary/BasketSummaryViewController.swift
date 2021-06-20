import CoffeeShopAPI
import UIKit

protocol BasketSummaryViewControllerDelegate: AnyObject {
  func basketSummary(_ basketSummary: BasketSummaryViewController, didCreateOrder: Order)
}

// TODO: Not allow to create order if out of business time. And showing something to guide user.
public class BasketSummaryViewController: UITableViewController {
  @IBOutlet var addressTextView: UITextView!

  weak var delegate: BasketSummaryViewControllerDelegate?
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
    let products = transform(items: dataSource.items)
    let request = CreateOrder(products: products, address: addressTextView.text)
    request.request { [weak self] result in
      guard let self = self else { return }
      self.createOrderHandler(result, order: request.parameters!)
    }
  }

  private func transform(items _: [(Product, UInt)]) -> [Product] {
    var products: [Product] = []
    dataSource.items.forEach { product, count in
      for _ in 0 ..< count {
        products.append(product)
      }
    }
    return products
  }

  private func createOrderHandler(_ result: Result<Empty, RequestError>, order: Order) {
    switch result {
    case .success:
      DispatchQueue.main.async {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.basketSummary(self, didCreateOrder: order)
      }
    case let .failure(error):
      let alert = DefaultAlert.instantiate(title: nil, message: error.localizedDescription)
      DispatchQueue.main.async {
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
}
