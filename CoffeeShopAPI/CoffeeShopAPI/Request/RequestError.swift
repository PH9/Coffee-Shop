public enum RequestError: Error {
  case onData
  case dataTask(Error)
  case parsing(Error)
}
