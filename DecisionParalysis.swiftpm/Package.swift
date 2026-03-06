// swift-tools-version: 6.0

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "DecisionParalysis",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "DecisionParalysis",
            targets: ["AppModule"],
            bundleIdentifier: "com.AnshGour.DecisionParalysis",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .bandage),
            accentColor: .presetColor(.cyan),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .locationWhenInUse(purposeString: "We need your location to quickly share it with emergency responders in case of an SOS.")
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ],
    swiftLanguageVersions: [.version("6")]
)