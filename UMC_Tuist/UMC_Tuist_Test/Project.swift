import ProjectDescription

let project = Project(
    name: "UMC_Tuist_Test",
    targets: [
        .target(
            name: "UMC_Tuist_Test",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.UMC-Tuist-Test",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["UMC_Tuist_Test/Sources/**"],
            resources: ["UMC_Tuist_Test/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "UMC_Tuist_TestTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.UMC-Tuist-TestTests",
            infoPlist: .default,
            sources: ["UMC_Tuist_Test/Tests/**"],
            resources: [],
            dependencies: [.target(name: "UMC_Tuist_Test")]
        ),
    ]
)
