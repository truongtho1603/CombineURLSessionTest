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
        // Products define the executables and libraries a package produces, and make them visible to other packages.
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
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CombineURLSessionExtension",
            dependencies: []),
        .target(
            name: "CombineURLSessionExtensionTest",
            dependencies: ["CombineURLSessionExtension"]),
        .testTarget(
            name: "CombineURLSessionExtensionUnitTests",
            dependencies: ["CombineURLSessionExtension"]),
        .testTarget(
            name: "CombineURLSessionExtensionTestUnitTests",
            dependencies: ["CombineURLSessionExtensionTest"])
    ]
)
