// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "pbimg",
    targets: [
        .executableTarget(
            name: "pbimg",
            path: "Sources"
        ),
        .testTarget(
            name: "PbimgTests",
            dependencies: ["pbimg"],
            path: "Tests"
        ),
    ]
)
