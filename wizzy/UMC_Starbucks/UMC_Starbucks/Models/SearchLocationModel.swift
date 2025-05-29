//
//  SearchLocationModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/19/25.
//

import Foundation

@Observable
class SearchLocationModel {
    var startPoint: String
    var endPoint: String


    init(startPoint: String, endPoint: String) {
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    
}
