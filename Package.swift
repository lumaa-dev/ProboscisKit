// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProboscisKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "ProboscisKit",
            targets: ["ProboscisKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.4.3")
    ],
    targets: [
        .target(
            name: "ProboscisKit",
            dependencies: [
                .product(name: "KeychainSwift", package: "keychain-swift"),
                .product(name: "SwiftSoup", package: "SwiftSoup")
            ]),
    ]
)
