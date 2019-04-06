# 🍋 acho

Acho is a Swift library to generate interactive CLI prompts.

**Where does acho come from?** People from Murcia, the region where I'm from use acho a lot when speaking. It's a word that can be used for many things: grab someone's attention, ask or complain about something, tell someone not to do something anymore. Since I found a parallelism between one of the usages of the expression, and the goal of this library, asking the user for something, I thought it'd be the perfect name for the library.

[![CircleCI](https://circleci.com/gh/tuist/acho.svg?style=svg)](https://circleci.com/gh/tuist/acho)
[![Swift Package Manager](https://img.shields.io/badge/swift%20package%20manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Release](https://img.shields.io/github/release/tuist/acho.svg)](https://github.com/tuist/acho/releases)
[![Code Coverage](https://codecov.io/gh/tuist/acho/branch/master/graph/badge.svg)](https://codecov.io/gh/tuist/acho)
[![Slack](http://slack.tuist.io/badge.svg)](http://slack.tuist.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/tuist/acho/blob/master/LICENSE.md)

## Install 🛠

### Swift Package Manager

Add the dependency in your `Package.swift` file:

```swift
let package = Package(
    name: "myproject",
    dependencies: [
        .package(url: "https://github.com/tuist/acho.git", .upToNextMajor(from: "0.2.0")),
        ],
    targets: [
        .target(
            name: "myproject",
            dependencies: ["acho"]),
        ]
)
```

### Using Marathon

If you want to use Acho in a [Marathon](https://github.com/johnsundell/marathon) script, either add it to your `Marathonfile` (see the Marathon repo for instructions on how to do that), or point Marathon to Acho using the inline dependency syntax:

```swift
import Acho // https://github.com/tuist/acho.git
```

## Usage 🚀

Create an instance of `Acho` passing the question and the options. The options need to conform both the protocol `CustomStringConvertible` and `Hashable`:

```swift
let simulators = ["iPhone 10", "iPhone 7" ]
let acho = Acho<String>()
let simulator = acho.ask(question: "In which simulator would you like to run the app?",
                         options: simulators)
```

![gif](assets/acho.gif)

## Testing ✅

Acho provides an `achoTesting` target that you can use to easily stub the interaction with the public interface:

```swift
import achoTesting

let mock = MockAcho<String>()
let simulators = ["iPhone 10", "iPhone 7" ]
mock.stub(question: "In which simulator would you like to run the app?", items: simulators, with: "iPhone 7")
```

## Setup for development 👩‍💻

1.  Git clone: `git@github.com:tuist/acho.git`
2.  Generate Xcode project with `swift package generate-xcodeproj`.
3.  Open `acho.xcodeproj`.
4.  Have fun 🤖

## Open source

Tuist is a proud supporter of the [Software Freedom Conservacy](https://sfconservancy.org/)

<a href="https://sfconservancy.org/supporter/"><img src="https://sfconservancy.org/img/supporter-badge.png" width="194" height="90" alt="Become a Conservancy Supporter!" border="0"/></a>
