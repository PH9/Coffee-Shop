import CoffeeShopAPI
import UIKit

final class StoreInfoViewController: UIViewController {
  @IBOutlet var storeNameLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var workHourLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    renderLoading()
    getStoreInfo()
    view.translatesAutoresizingMaskIntoConstraints = false
  }

  private func renderLoading() {
    storeNameLabel.text = "Loading..."
    ratingLabel.text = ""
    workHourLabel.text = ""
  }

  private func getStoreInfo() {
    StoreInfoRequest().request { [weak self] result in
      switch result {
      case let .success(info):
        DispatchQueue.main.async {
          self?.render(info)
        }
      default:
        break
      }
    }
  }

  private func render(_ info: StoreInfo) {
    storeNameLabel.text = info.name
    ratingLabel.text = "\(info.rating)/5"
    workHourLabel.text = "Opening hour: \(info.openingTime) - \(info.closingTime)"
  }
}
