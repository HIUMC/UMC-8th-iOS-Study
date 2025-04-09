//
//  NewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//

import Foundation

struct NewModel: Identifiable {
    let id = UUID()
    let imageName: String
    var title: String
    var description: String
}
