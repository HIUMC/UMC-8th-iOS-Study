//
//  NavigationRouter.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/1/25.
//

import SwiftUI
import Observation

class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()  // 네비게이션 경로를 저장하는 변수

    /// 특정 화면을 추가 (Push 기능)
    func push(_ route: Route) {
        path.append(route)
    }

    /// 마지막 화면 제거 (Pop 기능)
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    /// 네비게이션 초기화 (전체 Pop)
    func reset() {
        path = NavigationPath()
    }
}

enum Route: Hashable {
    case home
    case signup
    case login
    case tab
    case ad
    case receipts
}
