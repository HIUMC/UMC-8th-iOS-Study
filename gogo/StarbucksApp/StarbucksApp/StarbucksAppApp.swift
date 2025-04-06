//
//  StarbucksAppApp.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/2/25.
//

import SwiftUI

@main
struct StarbucksApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
        }
    }
}
