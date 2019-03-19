// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BulkLinkDownloader",
    dependencies: [
      .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
    ],
    targets: [
	.target(
		name: "BulkLinkDownloader",
		dependencies: ["SwiftSoup"]),
    ]
)
