import ProjectDescription

let project = Project(
    name: "Starbucks",
    packages: [
        .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.10.0"))
    ],
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
