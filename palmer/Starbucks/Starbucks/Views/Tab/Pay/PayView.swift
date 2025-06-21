//
//  otherPayView.swift
//  Starbucks
//
//  Created by 박정환 on 6/19/25.
//

import SwiftUI
import SwiftData
import Combine

struct PayView: View {
    var cards: [CardModel] = []

    @State private var selectedCardIndex: Int = 0
    @State private var remainingSeconds: Int = 180
    @State private var cardPositions: [Int: CGFloat] = [:]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private struct CardPositionPreferenceKey: PreferenceKey {
        static var defaultValue: [Int: CGFloat] = [:]
        static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
            value.merge(nextValue()) { $1 }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            navBar
            cardView
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onReceive(timer) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            }
        }
    }

    private var navBar: some View {
        HStack {
            Text("Pay")
                .foregroundStyle(.black)
                .font(.mainTextBold24)
            
            Spacer()
                .frame(width: 336)
            
            Button(action: {
                print("로그아웃")
            }, label: {
                Image(systemName: "plus")
                    .resizable()
                    .foregroundStyle(.black)
                    .frame(width: 16, height: 16)
            })
        }
        .background(.white)
    }
    
    private var cardScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(cards.indices, id: \.self) { index in
                    GeometryReader { geo in
                        let frame = geo.frame(in: .global)
                        let screenCenter = UIScreen.main.bounds.width / 2
                        let distance = abs(frame.midX - screenCenter)
                        let scale = max(1.0 - (distance / screenCenter) * 0.2, 0.85)

                        RoundedRectangle(cornerRadius: 12)
                            .fill(index == selectedCardIndex ? Color.green.opacity(0.2) : Color.gray.opacity(0.2))
                            .frame(width: 300, height: 180)
                            .scaleEffect(scale)
                            .animation(.easeInOut(duration: 0.2), value: scale)
                            .overlay(
                                Text("카드 \(index + 1)")
                            )
                            .shadow(radius: 5)
                            .background(
                                Color.clear
                                    .preference(key: CardPositionPreferenceKey.self, value: [index: frame.midX])
                            )
                    }
                    .frame(width: 300, height: 180)
                }
            }
            .padding(.horizontal, 32)
        }
        .frame(height: 200)
        .onPreferenceChange(CardPositionPreferenceKey.self) { positions in
            cardPositions = positions
            let center = UIScreen.main.bounds.width / 2
            if let closest = positions.min(by: { abs($0.value - center) < abs($1.value - center) }) {
                if selectedCardIndex != closest.key {
                    selectedCardIndex = closest.key
                    remainingSeconds = 180
                }
            }
        }
    }

    private var cardInfoView: some View {
        let selectedCard = cards[selectedCardIndex]

        return VStack(spacing: 8) {
            Text(selectedCard.name)
                .font(.headline)
            Text("\(selectedCard.balance)원")
                .font(.title2)
                .bold()
            Text(selectedCard.maskedCardNumber)
                .font(.subheadline)
                .foregroundColor(.gray)

            if remainingSeconds > 0 {
                (
                    Text("카드 유효 시간 ")
                        .foregroundColor(.gray)
                    + Text(formatTime(remainingSeconds))
                        .foregroundColor(.green)
                )
                .font(.caption)
            } else {
                Text("카드 유효시간이 만료되었습니다")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
    
    private var cardView: some View {
        VStack {
            if cards.isEmpty {
                Text("카드를 추가해주세요.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                cardScrollView
                cardInfoView
            }
        }
    }
    

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview {
    let cards = [
        CardModel(name: "아무카드 A", balance: 1200, cardNumber: "111122223333"),
        CardModel(name: "아무카드 B", balance: 3400, cardNumber: "444455556666"),
        CardModel(name: "아무카드 C", balance: 7800, cardNumber: "777788889999")
    ]
    return PayView(cards: cards)
}
