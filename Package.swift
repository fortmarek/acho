// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "acho",
    products: [
        .library(name: "acho", targets: ["acho"]),
        .library(name: "achoTesting", targets: ["achoTesting"]),
    ],
    dependencies: [
		.package(url: "https://github.com/tuist/tuist.git", .revision("e0e99b60b98489a27764846c86167ba64a0118f0")),
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
