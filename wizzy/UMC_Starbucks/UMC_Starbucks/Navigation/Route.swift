//
//  Route.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/9/25.
//

import SwiftUI

enum Route: Hashable {
    case signUp
    case detail(title: String)
    case profile(userID: Int)
}
