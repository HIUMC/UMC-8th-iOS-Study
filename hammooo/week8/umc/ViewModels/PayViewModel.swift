import Foundation
import SwiftData
import Combine

@MainActor
final class PayViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var selectedCardID: UUID?
    
    let timer = CountdownTimer()
    
    func loadCards(from context: ModelContext) {
        let descriptor = FetchDescriptor<Card>()
        if let result = try? context.fetch(descriptor) {
            cards = result.sorted { $0.name < $1.name }
            if selectedCardID == nil {
                selectedCardID = cards.first?.id
            }
        }
    }

    func onCardChange(to newID: UUID?) {
        if selectedCardID != newID {
            timer.reset()
        }
    }
}
