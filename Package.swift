// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineURLSession",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "CombineURLSessionExtension",
            targets: ["CombineURLSessionExtension"]),
        .library(
            name: "CombineURLSessionExtensionTest",
            targets: ["CombineURLSessionExtensionTest"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CombineURLSessionExtension",
            dependencies: []),
        .target(
            name: "CombineURLSessionExtensionTest",
            dependencies: ["CombineURLSessionExtension"]),
        .testTarget(
            name: "CombineURLSessionExtensionUnitTests",
            dependencies: ["CombineURLSessionExtensionTest"])
    ]
)
