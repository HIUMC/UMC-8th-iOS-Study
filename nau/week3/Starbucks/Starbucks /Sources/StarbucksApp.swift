import SwiftUI

@main
struct StarbucksApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
        }
    }
}
