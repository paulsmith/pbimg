// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "pbimg",
    targets: [
        .executableTarget(
            name: "pbimg"
        ),
        .testTarget(
            name: "PbimgTests",
            dependencies: ["pbimg"]
        ),
    ]
)
