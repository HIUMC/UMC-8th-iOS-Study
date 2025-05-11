//
//  NavigationRouter.swift
//  week3Practice
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI
import Observation

@Observable
class NavigationRouter {
    var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty { // 이거 확인 안해주면 crash난대
            path.removeLast()
        }
    }
    
    func reset() {
        path = NavigationPath()
    }
        
}
