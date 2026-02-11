// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "SparksMissionControl",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(
            name: "SparksMissionControl",
            targets: ["SparksMissionControl"]
        ),
    ],
    targets: [
        .executableTarget(
            name: "SparksMissionControl",
            path: "Sources/SparksMissionControl"
        ),
    ]
)
