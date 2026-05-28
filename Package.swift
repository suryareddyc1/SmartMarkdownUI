// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SmartMarkdownUI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SmartMarkdownUI",
            targets: ["SmartMarkdownUI"]
        )
    ],
    targets: [
        .target(
            name: "SmartMarkdownUI"
        ),
        .testTarget(
            name: "SmartMarkdownUITests",
            dependencies: ["SmartMarkdownUI"]
        )
    ]
)
