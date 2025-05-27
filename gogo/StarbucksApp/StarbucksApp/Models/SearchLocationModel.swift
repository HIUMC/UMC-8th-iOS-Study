//
//  SearchLocationModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/28/25.
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
