// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "snappy",
    platforms: [.macOS(.v11), .iOS(.v14)],
    products: [
        .library(
            name: "snappy",
            targets: ["snappy"]),
        .library(
            name: "libsnappy",
            targets: ["libsnappy"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "snappy",
            dependencies: ["snappyc"]),
        .target(name: "snappyc", dependencies: ["libsnappy"], linkerSettings: [.linkedLibrary("c++")]),
        .binaryTarget(name: "libsnappy", path: "Sources/libsnappy/libsnappy.xcframework"),
        .testTarget(
            name: "snappy-Tests",
            dependencies: ["snappy"],
            linkerSettings: [.linkedLibrary("c++")]),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx11
)
