// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EstalviaDesignSystem",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "EstalviaDesignSystem",
            targets: ["EstalviaDesignSystem"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
         .plugin(
         name: "EstalviaDesignSystemSwiftBuildToolPlugin",
         capability: .buildTool(),
         path: "Plugins/EstalviaDesignSystemSwiftBuildToolPlugin"
         ),
        .target(
            name: "EstalviaDesignSystem", plugins: [.plugin(name: "EstalviaDesignSystemSwiftBuildToolPlugin")]
        ),
        .testTarget(
            name: "EstalviaDesignSystemTests",
            dependencies: ["EstalviaDesignSystem"],
            plugins: [.plugin(name: "EstalviaDesignSystemSwiftBuildToolPlugin")]
        )
    ]
)
