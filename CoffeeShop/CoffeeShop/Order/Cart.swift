import CoffeeShopAPI

protocol CartUpdateSubscriber: AnyObject {
  func cart<T: Hashable>(_ cart: Cart<T>, didUpdate items: [T: UInt])
}

final class Cart<T: Hashable> {
  private(set) var items: [T: UInt] = [:] {
    didSet {
      subscribers.forEach { subscriber in
        subscriber.cart(self, didUpdate: items)
      }
    }
  }

  func add(item: T) -> UInt {
    guard var count = items[item] else {
      items[item] = 1
      return 1
    }

    count += 1
    items[item] = count
    return count
  }

  func reduce(item: T) -> UInt {
    guard var count = items[item] else {
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

  func set(item: T, count: UInt) -> UInt {
    if count == 0 {
      items[item] = nil
    } else {
      items[item] = count
    }
    return count
  }

  private var subscribers: [CartUpdateSubscriber] = []
  func subscribeToUpdate(subscriber: CartUpdateSubscriber) {
    subscribers.append(subscriber)
  }
}
