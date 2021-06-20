@testable import CoffeeShop
import XCTest

struct MyItem: Hashable {
  let id: Int
}

class SubscriberSpy: CartUpdateSubscriber {
  var cartDidUpdateCalledCount = 0
  var cartDidUpdateCart: Cart<MyItem>?
  var cartDidUpdateItems: [MyItem: UInt]?
  func cart<T>(_ cart: Cart<T>, didUpdate items: [T: UInt]) where T: Hashable {
    cartDidUpdateCalledCount += 1
    cartDidUpdateCart = cart as? Cart<MyItem>
    cartDidUpdateItems = items as? [MyItem: UInt]
  }
}

class CartTests: XCTestCase {
  var sut: Cart<MyItem>!
  var subscriberSpy: SubscriberSpy!

  let item0 = MyItem(id: 0)
  let item1 = MyItem(id: 1)

  override func setUp() {
    super.setUp()
    sut = Cart()
    subscriberSpy = SubscriberSpy()
    sut.subscribeToUpdate(subscriber: subscriberSpy)
  }

  func test_add_ifDifferentObjectShouldConsiderAsDifferentItem() {
    let firstResult = sut.add(item: item0)

    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item0], 1)
    XCTAssertEqual(firstResult, 1)
    XCTAssertEqual(subscriberSpy.cartDidUpdateCalledCount, 1)
    XCTAssert(subscriberSpy.cartDidUpdateCart === sut)
    XCTAssertEqual(subscriberSpy.cartDidUpdateItems, sut.items)

    let secondResult = sut.add(item: item0)

    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item0], 2)
    XCTAssertEqual(secondResult, 2)
    XCTAssertEqual(subscriberSpy.cartDidUpdateCalledCount, 2)
    XCTAssert(subscriberSpy.cartDidUpdateCart === sut)
    XCTAssertEqual(subscriberSpy.cartDidUpdateItems, sut.items)

    let thirdResult = sut.add(item: item1)

    XCTAssertEqual(sut.items.count, 2)
    XCTAssertEqual(sut.items[item0], 2)
    XCTAssertEqual(sut.items[item1], 1)
    XCTAssertEqual(thirdResult, 1)
    XCTAssertEqual(subscriberSpy.cartDidUpdateCalledCount, 3)
    XCTAssert(subscriberSpy.cartDidUpdateCart === sut)
    XCTAssertEqual(subscriberSpy.cartDidUpdateItems, sut.items)
  }

  func test_reduce_ifZeroOrUnderShouldClearItem() {
    let firstResult = sut.reduce(item: item0)

    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(firstResult, 0)
    XCTAssertEqual(subscriberSpy.cartDidUpdateCalledCount, 1)
    XCTAssert(subscriberSpy.cartDidUpdateCart === sut)
    XCTAssertEqual(subscriberSpy.cartDidUpdateItems, sut.items)

    _ = sut.add(item: item0)
    _ = sut.add(item: item0)
    _ = sut.reduce(item: item0)
    let clearResult = sut.reduce(item: item0)

    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(clearResult, 0)
    XCTAssertEqual(subscriberSpy.cartDidUpdateCalledCount, 5)
    XCTAssert(subscriberSpy.cartDidUpdateCart === sut)
    XCTAssertEqual(subscriberSpy.cartDidUpdateItems, sut.items)
  }

  func test_set() {
    let firstResult = sut.set(item: item0, count: 0)

    XCTAssertEqual(firstResult, 0)
    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(subscriberSpy.cartDidUpdateCalledCount, 1)
    XCTAssert(subscriberSpy.cartDidUpdateCart === sut)
    XCTAssertEqual(subscriberSpy.cartDidUpdateItems, sut.items)

    let secondResult = sut.set(item: item1, count: 10)

    XCTAssertEqual(secondResult, 10)
    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item1], 10)
    XCTAssertEqual(subscriberSpy.cartDidUpdateCalledCount, 2)
    XCTAssert(subscriberSpy.cartDidUpdateCart === sut)
    XCTAssertEqual(subscriberSpy.cartDidUpdateItems, sut.items)

    let thirdResult = sut.set(item: item0, count: 8)

    XCTAssertEqual(thirdResult, 8)
    XCTAssertEqual(sut.items.count, 2)
    XCTAssertEqual(sut.items[item0], 8)
    XCTAssertEqual(sut.items[item1], 10)
    XCTAssertEqual(subscriberSpy.cartDidUpdateCalledCount, 3)
    XCTAssert(subscriberSpy.cartDidUpdateCart === sut)
    XCTAssertEqual(subscriberSpy.cartDidUpdateItems, sut.items)
  }
}
