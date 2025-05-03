//
//  Route.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//
import SwiftUI


enum Route: Hashable { //Hashable을 채택해야 NavPath에서 이용 가능
    case signUp
    case login
    case coffeeDetail(CoffeeDetailModel)
    case goToTab
    case ad
    
    case addReceipt
    case storeMap
}
