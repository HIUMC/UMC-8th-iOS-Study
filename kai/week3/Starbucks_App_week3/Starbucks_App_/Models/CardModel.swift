//
//  CardModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 6/1/25.
//

import Foundation


struct CardModel: Identifiable, Hashable {
    let id = UUID()
    var imageName: String
    var title: String
}
