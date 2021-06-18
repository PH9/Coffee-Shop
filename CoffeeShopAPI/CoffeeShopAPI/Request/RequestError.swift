public enum RequestError: Error {
  case onData
  case dataTask(Error)
  case noResponse
  case responseIsNotHTTPURLResponse
  case unexpectedResponseCode(Int)
  case parsing(Error)
}
