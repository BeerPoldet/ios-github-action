import SwiftUI
import HelloWorld

@main
struct Main: App {
  var body: some Scene {
    WindowGroup {
      Text(greet(name: "Poldet", with: "Sawadee"))
    }
  }
}

