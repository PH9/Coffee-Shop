import CoffeeShopAPI

final class ProductListInteractor {
  let presenter = ProductListPresenter()

  func getProducts() {
    ProductRequest().request { [weak self] result in
      switch result {
      case let .success(products):
        self?.presenter.render(products: products)
      case let .failure(error):
        print(error)
      }
    }
  }
}

final class ProductListPresenter {
  weak var viewController: ProductListViewController?

  func render(products: [Product]) {
    DispatchQueue.main.async {
      self.viewController?.render(products: products)
    }
  }
}
