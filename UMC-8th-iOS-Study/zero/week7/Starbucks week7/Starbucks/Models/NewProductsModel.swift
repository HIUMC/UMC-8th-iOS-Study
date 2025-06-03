//
//  NewProductsModel.swift
//  Starbucks
//
//  Created by 김영택 on 4/10/25.
//

import Foundation

struct NewProductsModel: Identifiable, Hashable {
    let id = UUID()
    var newProductsImageName : String
    var newProductsName : String
}
