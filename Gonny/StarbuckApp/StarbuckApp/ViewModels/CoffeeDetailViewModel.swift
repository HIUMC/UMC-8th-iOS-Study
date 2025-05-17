//
//  Untitled.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/5/25.
//
/*import Foundation
 
 class CoffeeDetailViewModel: ObservableObject {
 @Published var coffee: CoffeeItem
 @Published var selectedTemp: TemperatureOption?
 
 init(coffee: CoffeeItem) {
 self.coffee = coffee
 }
 
 enum TemperatureOption: String {
 case hot = "HOT"
 case iced = "ICED"
 }
 }
*/
//실제 데이터가 들어오는 곳
import Foundation
import SwiftUI

class CoffeeDetailViewModel: ObservableObject {
    @Published var coffee: CoffeeItem

    init(coffee: CoffeeItem) {
        self.coffee = coffee
    }
    //핫먹을겨, 아이스먹을겨
    func selectTemperature(_ temp: CoffeeTemperature) {
            guard coffee.temperatureOption == .both else { return }
            coffee.selectedTemperature = temp
        }
}
