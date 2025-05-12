//
//  NewModel.swift
//  Starbucks
//
//  Created by 이가원 on 4/7/25.
//

import Foundation

struct NewModel: Identifiable,Hashable {
    let id = UUID()
    let imageName: String
    let title: String
}
