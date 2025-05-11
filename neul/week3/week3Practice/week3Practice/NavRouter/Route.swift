//
//  Route.swift
//  week3Practice
//
//  Created by tokkislove on 3/31/25.
//
import SwiftUI

enum Route: Hashable { //Hashable을 채택해야 NavPath에서 이용 가능
    case home
    case detail(title: String)
    case profile(userId: Int)
}


