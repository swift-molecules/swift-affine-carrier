// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-affine-carrier",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Affine Carrier",
            targets: ["Affine Carrier"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-affine",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-carrier",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ordinal-cardinal",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-tagged-carrier",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Affine Carrier",
            dependencies: [
                .product(name: "Affine", package: "swift-affine"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Ordinal Cardinal", package: "swift-ordinal-cardinal"),
            ]
        ),
        .testTarget(
            name: "Affine Carrier Tests",
            dependencies: [
                "Affine Carrier",
                .product(name: "Affine", package: "swift-affine"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Ordinal Cardinal", package: "swift-ordinal-cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Tagged Carrier", package: "swift-tagged-carrier"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = [
        .define(
            "SYNCHRONIZATION_AVAILABLE",
            .when(platforms: [.macOS, .iOS, .tvOS, .watchOS, .visionOS, .linux, .windows])
        )
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
