// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "acho",
    products: [
        .library(name: "acho", targets: ["acho"]),
        .library(name: "achoTesting", targets: ["achoTesting"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", .exact("0.3.0")),
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", .upToNextMinor(from: "1.2.0")),
    ],
    targets: [
        .target(
            name: "acho",
            dependencies: ["Utility", "ColorizeSwift"]
        ),
        .target(
            name: "cli",
            dependencies: ["acho"]
        ),
        .target(
            name: "achoTesting",
            dependencies: ["acho"]
        ),
        .testTarget(
            name: "achoTests",
            dependencies: ["acho"]
        ),
    ]
)
