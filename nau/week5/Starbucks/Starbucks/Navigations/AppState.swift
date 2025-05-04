//
//  AppState.swift
//  Starbucks
//
//  Created by nau on 4/3/25.
//
import SwiftUI
import Foundation

class AppState: ObservableObject {
    enum Flow {
        case login
        case main
    }
    
    @Published var flow: Flow = .login
}
