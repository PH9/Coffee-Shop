@testable import CoffeeShop
import XCTest

struct MyItem: Hashable {
  let id: Int
}

class CartTests: XCTestCase {
  var sut: Cart<MyItem>!

  override func setUp() {
    super.setUp()
    sut = Cart()
  }

  func test_add() {
    let item0 = MyItem(id: 0)

    let firstResult = sut.add(item: item0)

    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item0], 1)
    XCTAssertEqual(firstResult, 1)

    let secondResult = sut.add(item: item0)

    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item0], 2)
    XCTAssertEqual(secondResult, 2)
  }

  func test_reduce() {
    let item0 = MyItem(id: 0)

    let firstResult = sut.reduce(item: item0)

    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(firstResult, 0)

    _ = sut.add(item: item0)
    let thirdResult = sut.reduce(item: item0)

    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(thirdResult, 0)
  }
}
