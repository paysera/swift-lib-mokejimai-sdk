// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PayseraMokejimaiSDK",
    platforms: [.macOS(.v10_12), .iOS(.v10), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(name: "PayseraMokejimaiSDK", targets: ["PayseraMokejimaiSDK"]),
    ],
    dependencies: [
        .package(name: "PayseraCommonSDK", url: "https://github.com/paysera/swift-lib-common-sdk", from: "3.0.1")
    ],
    targets: [
        .target(
            name: "PayseraMokejimaiSDK",
            dependencies: ["PayseraCommonSDK"]
        ),
        .testTarget(
            name: "PayseraMokejimaiSDKTests",
            dependencies: ["PayseraMokejimaiSDK"]
        ),
    ]
)
