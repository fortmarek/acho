// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "acho",
    products: [
        .library(name: "acho", targets: ["acho"]),
        .library(name: "achoTesting", targets: ["achoTesting"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager", .branch("swift-5.0-RELEASE")), 
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", .revision("7492d039d594daccc39cacea343eed6cc9d1ed5a")),
    ],
    targets: [
        .target(
            name: "acho",
            dependencies: ["SPMUtility", "ColorizeSwift"]
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
