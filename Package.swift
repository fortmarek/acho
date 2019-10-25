// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "acho",
    products: [
        .library(name: "acho", targets: ["acho"]),
        .library(name: "achoTesting", targets: ["achoTesting"]),
    ],
    dependencies: [
		.package(url: "https://github.com/tuist/tuist.git", .branch("master")),
		.package(url: "https://github.com/mtynior/ColorizeSwift.git", .branch("master")),
        .package(url: "https://github.com/apple/swift-package-manager", .branch("swift-5.0-RELEASE")),
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
