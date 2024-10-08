// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of 
// Swift required to build this package.
import PackageDescription
let package = Package(
  name: "SSFacebookLogin",
  platforms: [.iOS(.v13)],
  products: [
    // Products define the executables and libraries a package produces,
    //and make them visible to other packages.
    .library(
      name: "SSFacebookLogin",
      targets: ["SSFacebookLogin"]
    ),
  ],
  dependencies: [  
   .package(url: "https://github.com/facebook/facebook-ios-sdk.git", from: "17.0.2")
  ],
  targets: [
    // Targets are the basic building blocks of a package. 
    // A target can define a module or a test suite.
    // Targets can depend on other targets in this package,
    // and products in packages this package depends on.
    .target(
      name: "SSFacebookLogin",
      dependencies: [
        .product(name: "FacebookLogin", package: "facebook-ios-sdk")
        ],
      path: "Classes"
     ) 
  ]
)