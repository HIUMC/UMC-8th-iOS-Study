//
//  NavigationRouter.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/3/25.
//

import SwiftUI
import Observation

enum Route: Hashable {
    case signup
    case cafeMenu(MenuDetailModel)
    case receipt
}

class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        if(!path.isEmpty) {
            path.removeLast()
        }
        
    }
    
    func reset() {
        path = NavigationPath()
    }
}
