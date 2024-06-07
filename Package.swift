// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iss",
    dependencies: [
        .package(url: "https://github.com/apple/example-package-figlet", branch: "main"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.6.0"),
        .package(url: "https://github.com/csanfilippo/swift-sgp4", from: "1.2.0"),
        .package(url: "https://github.com/pakLebah/ANSITerminal", from: "0.0.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "iss",
        dependencies: [
            .product(name: "Figlet", package: "example-package-figlet"),
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            .byName(name: "SwiftSoup"),
            .product(name: "SGPKit", package: "swift-sgp4"),
            .byName(name: "ANSITerminal")
        ],
        path: "Sources"),
    ]
)
