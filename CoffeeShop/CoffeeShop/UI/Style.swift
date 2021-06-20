import UIKit

typealias Style<T: NSObject> = (T) -> T

infix operator <~: LeftFirst

precedencegroup LeftFirst {
  associativity: left
}

@discardableResult
func <~ <T: NSObject>(_ view: T, _ style: Style<T>) -> T {
  style(view)
}

let rounded: Style<UIView> = { view in
  view.layer.cornerRadius = 3
  return view
}
