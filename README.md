# ProtectedFromScreenshot

A simple wrapper view that is able to protected from screenshot or screen recording on iOS.

## Requirement

iOS 13+, Swift 5.9+.

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate ProtectedFromScreenshot into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/KolesnevDenis/ProtectedFromScreenshot", .upToNextMajor(from: "1.0.0"))
]
```

## SwiftUI Usage

Simply wrap your view inside `ProtectedFromScreenshot` View. 
You should pass in a isProtected binding to toggle on whether to prevent screenshot or not.

```swift
import SwiftUI
import ProtectedFromScreenshot

struct ContentView: View {

    var body: some View {
        ProtectedFromScreenshot(isProtected: true) {
            Text("Hello")
                .padding()
                .background(.yellow)
                .cornerRadius(12)
        }
    }
}
```

or using view modifier extension

```swift
import SwiftUI
import ProtectedFromScreenshot

struct ContentView: View {

    var body: some View {
        Text("Hello")
            .padding()
            .background(.yellow)
            .cornerRadius(12)
            .protectedFromScreenshot(isProtected: true)
    }
}
```
