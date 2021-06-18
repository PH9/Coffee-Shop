import CoffeeShopAPI

struct MyRequest: Requestable {
  let path = "/this-path"
  typealias ResponseType = MyResponse
}
