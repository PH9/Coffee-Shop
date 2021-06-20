import CoffeeShopAPI

protocol BasketUpdateSubscriber: AnyObject {
  func basket<T: Sellable>(_ basket: Basket<T>, didUpdate items: [T: UInt])
}

protocol Sellable: Hashable {
  var price: UInt { get }
}

final class Basket<T: Sellable> {
  private(set) var items: [T: UInt] = [:] {
    didSet {
      subscribers.forEach { subscriber in
        subscriber.basket(self, didUpdate: items)
      }
    }
  }

  @discardableResult
  func add(item: T) -> UInt {
    guard var count = items[item] else {
      items[item] = 1
      return 1
    }

    count += 1
    items[item] = count
    return count
  }

  @discardableResult
  func reduce(item: T) -> UInt {
    guard var count = items[item] else {
      items[item] = nil
      return 0
    }

    count -= 1
    if count <= 0 {
      items[item] = nil
      return 0
    }
    items[item] = count
    return count
  }

  @discardableResult
  func set(item: T, count: UInt) -> UInt {
    if count == 0 {
      items[item] = nil
    } else {
      items[item] = count
    }
    return count
  }

  func removeAll() {
    items = [:]
  }

  private var subscribers: [BasketUpdateSubscriber] = []
  func subscribeToUpdate(subscriber: BasketUpdateSubscriber) {
    subscribers.append(subscriber)
  }
}
