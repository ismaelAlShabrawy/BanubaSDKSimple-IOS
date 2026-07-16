// swift-tools-version:5.9

import PackageDescription

let banubaCoreVersionRange: Range<Version> = "1.53.0-beta.0"..<"1.53.99"

let package = Package(
  name: "BanubaSdkSimple",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "BanubaSdkSimple",
      targets: ["BanubaSdkSimpleTarget"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/Banuba/BanubaUtilities-iOS.git", from: "1.53.0"),
    .package(url: "https://github.com/Banuba/BanubaVideoEditorCore-iOS.git", banubaCoreVersionRange)
  ],
  targets: [
    // Local development uses the path-based binaryTarget below.
    // Release flow (fastlane patch_package_swift_for_nexus) replaces it in the GitHub distribution repo with:
    // .binaryTarget(
    //   name: "BanubaSdkSimple",
    //   url: "https://nexus.banuba.net/repository/ios-frameworks/ios/frameworks/BanubaSDKSimple/{version}/BanubaSdkSimple-{version}.xcframework.zip",
    //   checksum: "{computed at release}"
    // )
    .binaryTarget(
      name: "BanubaSdkSimple",
      url: "https://nexus.banuba.net/repository/ios-frameworks/ios/frameworks/BanubaSDKSimple/1.53.0/BanubaSdkSimple-1.53.0.xcframework.zip",
      checksum: "7f8224d5574863f23c8a4d4f1f276b6a87646fab706bc2d6d23ca69ec0a407bc"
    ),
    .target(
      name: "BanubaSdkSimpleTarget",
      dependencies: [
        .target(name: "BanubaSdkSimpleWrapper")
      ],
      path: "BanubaSdkSimpleTarget"
    ),
    .target(
      name: "BanubaSdkSimpleWrapper",
      dependencies: [
        "BanubaSdkSimple",
        .product(name: "BanubaUtilities", package: "BanubaUtilities-iOS"),
        .product(name: "BanubaVideoEditorCore", package: "BanubaVideoEditorCore-iOS"),
      ],
      path: "BanubaSdkSimpleWrapper"
    ),
  ]
)
