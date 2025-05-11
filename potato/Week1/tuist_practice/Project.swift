import ProjectDescription

let project = Project(
    name: "tuist_practice",
    targets: [
        .target(
            name: "tuist_practice",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.tuist-practice",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["tuist_practice/Sources/**"],
            resources: ["tuist_practice/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "tuist_practiceTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.tuist-practiceTests",
            infoPlist: .default,
            sources: ["tuist_practice/Tests/**"],
            resources: [],
            dependencies: [.target(name: "tuist_practice")]
        ),
    ]
)
