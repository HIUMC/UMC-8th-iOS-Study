import SwiftUI
import SwiftData

@main
struct StarbucksAppApp: App {
    var body: some Scene {
        WindowGroup {
            PayView()
        }
        .modelContainer(for: CardModel.self)
    }
}
