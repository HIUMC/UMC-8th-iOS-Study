//
//  PayViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 6/19/25.
//
import SwiftUI
import SwiftData

class PayViewModel: ObservableObject {
    @Published var cards: [Card]
    @Published var selectedIndex: Int = 0
    /*
     let cardNumber: String
     let money: Int
     */
    private var timer: Timer?
    
    init() {
        // 샘플 데이터
        self.cards = [
            Card(imageName: "starbucks", name: "아무카드 A", price: 999, cardNumber: "1234-1234-1234", money: nil , initialSeconds: 180, remainingSeconds: 180),
            Card(imageName: "paris", name: "아무카드 B", price: 1200, cardNumber: "5678-5678-5678", money: nil, initialSeconds: 140, remainingSeconds: 140)
        ]
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            var updated = self.cards
            if updated[self.selectedIndex].remainingSeconds > 0 {
                updated[self.selectedIndex].remainingSeconds -= 1
                self.cards = updated
            }
        }
    }
    
    func selectCard(_ idx: Int) {
        selectedIndex = idx
        // 카드 스와이프 시 유효시간 리셋
        var updated = cards
        updated[idx].remainingSeconds = updated[idx].initialSeconds
        cards = updated
        startTimer()
    }
    
    // 카드 번호 마스킹
    func maskedNumber(_ num: String) -> String {
        let last4 = num.suffix(4)
        return "**** **** **** \(last4)"
    }
    
    // 유효시간 표시
    func formattedTime(_ seconds: Int) -> String {
        if seconds <= 0 {
            return "카드 유효시간이 만료되었습니다."
        }
        let min = seconds / 60
        let sec = seconds % 60
        return String(format: "%02d:%02d", min, sec)
    }
    
    func timeColor(_ seconds: Int) -> Color {
        seconds <= 0 ? .gray : .green
    }
}
