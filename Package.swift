// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "acho",
    products: [
        .library(name: "acho", targets: ["acho"]),
        .library(name: "achoTesting", targets: ["achoTesting"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager", .revision("a107d28d1b40491cf505799a046fee53e7c422e1")),
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", .revision("7492d039d594daccc39cacea343eed6cc9d1ed5a")),
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
