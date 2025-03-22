import ProjectDescription

let project = Project(
    name: "UMC_TUIST_TEST",
    targets: [
        .target(
            name: "UMC_TUIST_TEST",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.UMC-TUIST-TEST",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["UMC_TUIST_TEST/Sources/**"],
            resources: ["UMC_TUIST_TEST/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "UMC_TUIST_TESTTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.UMC-TUIST-TESTTests",
            infoPlist: .default,
            sources: ["UMC_TUIST_TEST/Tests/**"],
            resources: [],
            dependencies: [.target(name: "UMC_TUIST_TEST")]
        ),
    ]
)
