import CoffeeShopAPI

protocol CartUpdateSubscriber: AnyObject {
  func cart<T: Hashable>(_ cart: Cart<T>, didUpdate items: [T: Int])
}

final class Cart<T: Hashable> {
  private(set) var items: [T: Int] = [:] {
    didSet {
      subscribers.forEach { subscriber in
        subscriber.cart(self, didUpdate: items)
      }
    }
  }

  func add(item: T) -> Int {
    guard var count = items[item] else {
      items[item] = 1
      return 1
    }

    count += 1
    items[item] = count
    return count
  }

  func reduce(item: T) -> Int {
    guard var count = items[item] else {
      return 0
    }

    count -= 1
    count = count < 0 ? 0 : count
    items[item] = count
    return count
  }

  func set(item: T, count: Int?) -> Int {
    items[item] = count ?? items[item]
    return items[item] ?? 0
  }

  private var subscribers: [CartUpdateSubscriber] = []
  func subscribeToUpdate(subscriber: CartUpdateSubscriber) {
    subscribers.append(subscriber)
  }
}
