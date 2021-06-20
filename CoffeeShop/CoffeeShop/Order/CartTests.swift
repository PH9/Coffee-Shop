@testable import CoffeeShop
import XCTest

struct MyItem: Hashable {
  let id: Int
}

class CartTests: XCTestCase {
  var sut: Cart<MyItem>!

  let item0 = MyItem(id: 0)
  let item1 = MyItem(id: 1)

  override func setUp() {
    super.setUp()
    sut = Cart()
  }

  func test_add_ifDifferentObjectShouldConsiderAsDifferentItem() {
    let firstResult = sut.add(item: item0)

    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item0], 1)
    XCTAssertEqual(firstResult, 1)

    let secondResult = sut.add(item: item0)

    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item0], 2)
    XCTAssertEqual(secondResult, 2)

    let thirdResult = sut.add(item: item1)

    XCTAssertEqual(sut.items.count, 2)
    XCTAssertEqual(sut.items[item0], 2)
    XCTAssertEqual(sut.items[item1], 1)
    XCTAssertEqual(thirdResult, 1)
  }

  func test_reduce_ifZeroOrUnderShouldClearItem() {
    let firstResult = sut.reduce(item: item0)

    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(firstResult, 0)

    _ = sut.add(item: item0)
    _ = sut.add(item: item0)
    _ = sut.reduce(item: item0)
    let clearResult = sut.reduce(item: item0)

    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(clearResult, 0)
  }

  func test_set() {
    let firstResult = sut.set(item: item0, count: 0)

    XCTAssertEqual(firstResult, 0)
    XCTAssertEqual(sut.items.count, 0)

    let secondResult = sut.set(item: item1, count: 10)

    XCTAssertEqual(secondResult, 10)
    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item1], 10)

    let thirdResult = sut.set(item: item0, count: 8)

    XCTAssertEqual(thirdResult, 8)
    XCTAssertEqual(sut.items.count, 2)
    XCTAssertEqual(sut.items[item0], 8)
    XCTAssertEqual(sut.items[item1], 10)
  }
}
