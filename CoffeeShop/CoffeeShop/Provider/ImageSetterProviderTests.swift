@testable import CoffeeShop
import XCTest

final class ImageSetterProviderSpy: ImageSetterProvider {
  var setImageCalledCount = 0
  var setImageURL: URL?
  var setImageImageView: UIImageView?
  func setImage(from url: URL, to imageView: UIImageView) {
    setImageCalledCount += 1
    setImageURL = url
    setImageImageView = imageView
  }
}

final class ImageSetterProviderTests: XCTestCase {
  func test() {
    let spy = ImageSetterProviderSpy()
    CoffeeShopConfigurator.setSetImageProvider(spy)
    let imageView = UIImageView()

    imageView.setImage(with: .placeholder)

    XCTAssertEqual(spy.setImageCalledCount, 1)
    XCTAssertEqual(spy.setImageURL, .placeholder)
    XCTAssertEqual(spy.setImageImageView, imageView)
  }
}
