//  PayView.swift
//  Starbucks_project

import SwiftUI
import SwiftData

struct PayView: View {
    @State private var activeID: PersistentIdentifier?

    @Query var cards: [PayModel]

    @StateObject private var viewModel = PayViewModel()
    @Environment(\.modelContext) private var context

    @State private var timeRemaining = 180
    @State private var timer: Timer?

    @State private var isPresentingAddSheet = false

    var body: some View {
        HStack {
            Text("Pay")
                .font(.mainTextBold24)
                .foregroundColor(.black01)

            Spacer()

            Button(action: {
                isPresentingAddSheet = true
            }) {
                Image(systemName: "plus")
                    .font(.mainTextBold24)
                    .foregroundColor(.black01)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)

        NavigationStack {
            VStack {
                CustomCarousel(config: .init(hasOpacity: true, hasScale: true, cardWidth: 200, minimumCardWidth: 30), selection: $activeID, data: cards) { item in
                    if let uiImage = item.image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image("pluscard")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(height: 140)

                if let selectedCard = cards.first(where: { $0.id == activeID }) ?? cards.first {
                    VStack(spacing: 6) {
                        Text(selectedCard.name)
                            .font(.headline)
                        Text("\(selectedCard.balance)\u{C6D0}")
                            .font(.subheadline)
                        Text(selectedCard.maskedCardNumber)
                            .font(.footnote)
                            .foregroundStyle(.gray)

                        if timeRemaining == 0 {
                            Text("카드 유효시간이 만료되었습니다")
                                .foregroundColor(.red)
                                .font(.caption)
                        } else {
                            Text("유효시간: \(timeRemaining)초")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                } else {
                    Text("등록된 카드가 없습니다.")
                        .foregroundStyle(.gray)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $isPresentingAddSheet) {
                AddCardView()
            }
            .onAppear {
                viewModel.addDummyCards(context: context)
                resetTimer()
            }
        }
    }

    func resetTimer() {
        timeRemaining = 180
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
}

#Preview {
    PayView()
        .modelContainer(for: PayModel.self, inMemory: true)
}
