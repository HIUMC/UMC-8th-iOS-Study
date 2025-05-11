//
//  NavigationRouter.swift
//  Starbucks
//
//  Created by 고석현 On 4/4/26

//
import SwiftUI
import Observation

class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    // 특정 화면을 추가 (Push 기능)
    func push(_ route: Route) {
        path.append(route)
    }
    // 마지막 화면 제거 (Pop 기능)
    func pop() {
        if !path.isEmpty { // 이거 확인 안해주면 crash
            path.removeLast()
        }
    }
    // 네비게이션 초기화 (전체 Pop)
    func reset() {
        path = NavigationPath()
    }
        
}
