@testable import CoffeeShop
import XCTest

class SubscriberSpy: BasketUpdateSubscriber {
  var basketDidUpdateCalledCount = 0
  var basketDidUpdateBasket: Basket<SellableItem>?
  var basketDidUpdateItems: [SellableItem: UInt]?
  func basket<T>(_ basket: Basket<T>, didUpdate items: [T: UInt]) where T: Hashable {
    basketDidUpdateCalledCount += 1
    basketDidUpdateBasket = basket as? Basket<SellableItem>
    basketDidUpdateItems = items as? [SellableItem: UInt]
  }
}

class BasketTests: XCTestCase {
  var sut: Basket<SellableItem>!
  var subscriberSpy: SubscriberSpy!

  let item0 = SellableItem(price: 0)
  let item1 = SellableItem(price: 1)

  override func setUp() {
    super.setUp()
    sut = Basket()
    subscriberSpy = SubscriberSpy()
    sut.subscribeToUpdate(subscriber: subscriberSpy)
  }

  func test_add_ifDifferentObjectShouldConsiderAsDifferentItem() {
    let firstResult = sut.add(item: item0)

    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item0], 1)
    XCTAssertEqual(firstResult, 1)
    XCTAssertEqual(subscriberSpy.basketDidUpdateCalledCount, 1)
    XCTAssert(subscriberSpy.basketDidUpdateBasket === sut)
    XCTAssertEqual(subscriberSpy.basketDidUpdateItems, sut.items)

    let secondResult = sut.add(item: item0)

    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item0], 2)
    XCTAssertEqual(secondResult, 2)
    XCTAssertEqual(subscriberSpy.basketDidUpdateCalledCount, 2)
    XCTAssert(subscriberSpy.basketDidUpdateBasket === sut)
    XCTAssertEqual(subscriberSpy.basketDidUpdateItems, sut.items)

    let thirdResult = sut.add(item: item1)

    XCTAssertEqual(sut.items.count, 2)
    XCTAssertEqual(sut.items[item0], 2)
    XCTAssertEqual(sut.items[item1], 1)
    XCTAssertEqual(thirdResult, 1)
    XCTAssertEqual(subscriberSpy.basketDidUpdateCalledCount, 3)
    XCTAssert(subscriberSpy.basketDidUpdateBasket === sut)
    XCTAssertEqual(subscriberSpy.basketDidUpdateItems, sut.items)
  }

  func test_reduce_ifZeroOrUnderShouldClearItem() {
    let firstResult = sut.reduce(item: item0)

    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(firstResult, 0)
    XCTAssertEqual(subscriberSpy.basketDidUpdateCalledCount, 1)
    XCTAssert(subscriberSpy.basketDidUpdateBasket === sut)
    XCTAssertEqual(subscriberSpy.basketDidUpdateItems, sut.items)

    _ = sut.add(item: item0)
    _ = sut.add(item: item0)
    _ = sut.reduce(item: item0)
    let clearResult = sut.reduce(item: item0)

    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(clearResult, 0)
    XCTAssertEqual(subscriberSpy.basketDidUpdateCalledCount, 5)
    XCTAssert(subscriberSpy.basketDidUpdateBasket === sut)
    XCTAssertEqual(subscriberSpy.basketDidUpdateItems, sut.items)
  }

  func test_set() {
    let firstResult = sut.set(item: item0, count: 0)

    XCTAssertEqual(firstResult, 0)
    XCTAssertEqual(sut.items.count, 0)
    XCTAssertEqual(subscriberSpy.basketDidUpdateCalledCount, 1)
    XCTAssert(subscriberSpy.basketDidUpdateBasket === sut)
    XCTAssertEqual(subscriberSpy.basketDidUpdateItems, sut.items)

    let secondResult = sut.set(item: item1, count: 10)

    XCTAssertEqual(secondResult, 10)
    XCTAssertEqual(sut.items.count, 1)
    XCTAssertEqual(sut.items[item1], 10)
    XCTAssertEqual(subscriberSpy.basketDidUpdateCalledCount, 2)
    XCTAssert(subscriberSpy.basketDidUpdateBasket === sut)
    XCTAssertEqual(subscriberSpy.basketDidUpdateItems, sut.items)

    let thirdResult = sut.set(item: item0, count: 8)

    XCTAssertEqual(thirdResult, 8)
    XCTAssertEqual(sut.items.count, 2)
    XCTAssertEqual(sut.items[item0], 8)
    XCTAssertEqual(sut.items[item1], 10)
    XCTAssertEqual(subscriberSpy.basketDidUpdateCalledCount, 3)
    XCTAssert(subscriberSpy.basketDidUpdateBasket === sut)
    XCTAssertEqual(subscriberSpy.basketDidUpdateItems, sut.items)
  }
}
