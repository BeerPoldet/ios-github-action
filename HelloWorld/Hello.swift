import Prelude

public func greet(name: String, with word: String?) -> String {
  (word ?? "Hello") |> { flatten([$0, ", ", name]) }
}

public let _greet = curry(greet)

func flatten<A: Monoid>(_ xs: [A]) -> A {
  xs.reduce(.mempty, { acc, x in acc.mappend(x) })
}

protocol Monoid {
  func mappend(_ a: Self) -> Self

  static var mempty: Self { get }
}

extension String: Monoid {
  func mappend(_ a: String) -> String {
    self + a
  }

  static var mempty: Self { "" }
}
