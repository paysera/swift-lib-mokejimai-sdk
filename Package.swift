// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PayseraMokejimaiSDK",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "PayseraMokejimaiSDK", targets: ["PayseraMokejimaiSDK"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/paysera/swift-lib-common-sdk",
            from: "4.3.0"
        )
    ],
    targets: [
        .target(
            name: "PayseraMokejimaiSDK",
            dependencies: [
                .product(name: "PayseraCommonSDK", package: "swift-lib-common-sdk")
            ]
        ),
        .testTarget(
            name: "PayseraMokejimaiSDKTests",
            dependencies: ["PayseraMokejimaiSDK"]
        ),
    ]
)
