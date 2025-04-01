import ProjectDescription

let project = Project(
    name: "Starbucks",
    targets: [
        .target(
            name: "Starbucks",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Starbucks",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Starbucks/Sources/**"],
            resources: ["Starbucks/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "StarbucksTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.StarbucksTests",
            infoPlist: .default,
            sources: ["Starbucks/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Starbucks")]
        ),
    ]
)
