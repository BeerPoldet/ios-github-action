import SwiftUI
import HelloWorld
import Add

@main
struct Main: App {
  var body: some Scene {
    WindowGroup {
      VStack {
        Text(greet(name: "Poldet", with: "Sawadee"))
        Text("1 + 2 = \(add(1)(2))")
      }
    }
  }
}

