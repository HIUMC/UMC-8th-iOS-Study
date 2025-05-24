//
//  OrderModel.swift
//  Starbucks
//
//  Created by 이가원 on 5/23/25.
//

import SwiftUI
import Foundation

struct OrderMenu: Identifiable {
    let id : UUID
    let nameKo: String
    let nameEn: String
    let imageName: String
    let isNew: Bool
}
