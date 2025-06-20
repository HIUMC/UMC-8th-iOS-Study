import Foundation
import SwiftData

@Model
final class Card: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var price: Int
    var number: String
    var imageName: String

    init(name: String, price: Int, number: String, imageName: String) {
        self.name = name
        self.price = price
        self.number = number
        self.imageName = imageName
    }
}
