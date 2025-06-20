//
//  PayView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/2/25.
//

import SwiftUI
import SwiftData

private struct CardPositionPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

@MainActor
struct PayView: View {
    @Query var cards: [CardModel]
    @State private var currentIndex: Int = 0
    @State private var remainingTime: Int = 0
    @State private var timer: Timer? = nil

    var body: some View {
        VStack {
            HStack {
                Text("Pay")
                    .font(.PretendardBold24)
                Spacer()
                Button {
                    // action
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            CoverCarouselView(cards: cards, currentIndex: $currentIndex)
                .onChange(of: currentIndex) {
                    timer?.invalidate()
                    let newActivationDate = Date()
                    cards[currentIndex].activationDate = newActivationDate
                    let expirationDate = newActivationDate.addingTimeInterval(180)
                    updateRemainingTime(expirationDate: expirationDate)

                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        updateRemainingTime(expirationDate: expirationDate)
                    }
                }
                .onDisappear {
                    timer?.invalidate()
                }

            if cards.indices.contains(currentIndex) {
                VStack(spacing: 8) {
                    Text(cards[currentIndex].cardName)
                        .font(.PretendardRegular13)

                    Text("\(cards[currentIndex].cardMoney)원")
                        .font(.PretendardSemiBold18)

                    if remainingTime > 0 {
                        let minutes = remainingTime / 60
                        let seconds = remainingTime % 60
                        Text("카드 유효 시간 \(String(format: "%02d:%02d", minutes, seconds))")
                            .font(.caption)
                            .foregroundColor(.green)
                    } else {
                        Text("카드 유효시간이 만료되었습니다.")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Text(hideNumber(cards[currentIndex].cardNumber))
                        .font(.caption)
                }
                .padding(.top, 20)
            }
        }
        Spacer()
    }

    private func hideNumber(_ number: String) -> String {
        let digits = number.replacingOccurrences(of: "-", with: "")
        guard digits.count == 16 else { return number }
        return "****-****-****-\(digits.suffix(4))" // 마지막 4자리만 보여주기
    }

    private func updateRemainingTime(expirationDate: Date) {
        let remaining = Int(expirationDate.timeIntervalSinceNow)
        remainingTime = max(remaining, 0)
    }
}

struct CoverCarouselView: View {
    let cards: [CardModel]
    @Binding var currentIndex: Int

    var body: some View {
        GeometryReader { outerProxy in
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(cards.indices, id: \.self) { index in
                            GeometryReader { geo in
                                let midX = geo.frame(in: .global).midX
                                let distance = abs(midX - outerProxy.size.width / 2)
                                let scale = max(1 - distance / 500, 0.85)

                                Image(cards[index].imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 272, height: 143)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .scaleEffect(scale)
                                    .shadow(radius: 4)
                                    .background(
                                        GeometryReader { geo in
                                            Color.clear
                                                .preference(
                                                    key: CardPositionPreferenceKey.self,
                                                    value: [index: geo.frame(in: .global).midX]
                                                )
                                        }
                                    )
                            }
                            .frame(width: 272, height: 143)
                            .id(index)
                        }
                    }
                    .padding(.horizontal, (outerProxy.size.width - 272) / 2)
                }
                .scrollTargetLayout()
            }
            .onPreferenceChange(CardPositionPreferenceKey.self) { values in
                let center = outerProxy.size.width / 2
                let closest = values.min(by: { abs($0.value - center) < abs($1.value - center) })?.key
                if let closest = closest {
                    currentIndex = closest
                }
            }
        }
        .frame(height: 180)
    }
}
