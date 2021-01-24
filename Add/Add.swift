import Prelude

private func _add(_ a: Int, _ b: Int) -> Int {
  a + b
}

public let add = curry(_add)
