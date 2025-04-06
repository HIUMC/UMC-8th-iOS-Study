//
//  WhatModel.swift
//  Starbucks
//
//  Created by 김영택 on 4/7/25.
//

import Foundation

struct WhatModel: Identifiable, Hashable {
    let id = UUID()
    let imageName : String
    let title : String
    let add : String
}
