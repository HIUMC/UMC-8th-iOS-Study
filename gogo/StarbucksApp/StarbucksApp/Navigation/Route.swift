//
//  Route.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/9/25.


//Hashable 프로토콜 채택해야 NavigationPath에서 사용가능 & 단순 이동이 아니라 화면에서 필요한 데이터 함께 전달
//NavitgationRouter에 대해서 복습하기..
//일단 워크북  양식 보고 최대한..
import Foundation

import SwiftUI


enum Route: Hashable {
    case signUp
    case login
    case detailCoffee
    case tabBarView
    case ad
}
