//
//  Untitled.swift
//  Starbucks
//
//  Created by nau on 4/1/25.
//

import SwiftUI
import Foundation

enum Route: Hashable {
    case login
    case signup
    case tab
    case detail(DetailMenuModel)
}
