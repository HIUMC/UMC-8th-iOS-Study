import Foundation
import SwiftData

@Model
class Receipt {
    @Attribute(.unique) var id: UUID
    var store: String
    var date: Date
    var total: Int
    var image: ReceiptImage?

    init(store: String, date: Date, total: Int, image: ReceiptImage? = nil) {
        self.id = UUID()
        self.store = store
        self.date = date
        self.total = total
        self.image = image
    }
}

@Model
class ReceiptImage {
    var imageData: Data

    init(imageData: Data) {
        self.imageData = imageData
    }
}
