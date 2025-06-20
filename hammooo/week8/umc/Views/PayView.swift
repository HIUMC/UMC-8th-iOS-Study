import SwiftUI
import SwiftData

struct PayView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var vm = PayViewModel()

    var body: some View {
        VStack(spacing: 24) {
            // ---------- Carousel ----------
            TabView(selection: $vm.selectedCardID) {
                ForEach(vm.cards, id: \.id) { card in
                    Image(card.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                        .tag(card.id)  // 반드시 tag 필요!
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 140)

            // ---------- 카드 정보 ----------
            if let card = vm.cards.first(where: { $0.id == vm.selectedCardID }) {
                CardInfoView(card: card, secondsLeft: vm.timer.secondsLeft)
            } else {
                Text("등록된 카드가 없습니다.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            bootstrapIfNeeded(context)
            vm.loadCards(from: context)
            vm.timer.start()
        }
        .onDisappear {
            vm.timer.stop()
        }
        .onChange(of: vm.selectedCardID) { newID in
            vm.onCardChange(to: newID)
        }
        .navigationTitle("Pay")
        .toolbar {
            Button(systemName: "plus") {
             
            }
        }
    }
}


extension String {
    var maskedCardNumber: String {
        let digits = self.filter(\.isNumber)
        guard digits.count >= 4 else { return self }
        return "****-****-****-\(digits.suffix(4))"
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

@MainActor
func bootstrapIfNeeded(_ context: ModelContext) {
    let descriptor = FetchDescriptor<Card>()
    if let existing = try? context.fetch(descriptor), existing.isEmpty {
        let cardA = Card(name: "아무카드 A", price: 1000, number: "123456789012", imageName: "cardA")
        let cardB = Card(name: "아무카드 B", price: 2000, number: "987654321234", imageName: "cardA")
        context.insert(cardA)
        context.insert(cardB)
        try? context.save()
    }
}


#Preview {
    PayView()
}
