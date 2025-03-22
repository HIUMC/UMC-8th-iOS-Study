import ProjectDescription

let project = Project(
    name: "1st_work",
    targets: [
        .target(
            name: "1st_work",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.1st-work",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["1st_work/Sources/**"],
            resources: ["1st_work/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "1st_workTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.1st-workTests",
            infoPlist: .default,
            sources: ["1st_work/Tests/**"],
            resources: [],
            dependencies: [.target(name: "1st_work")]
        ),
    ]
)
