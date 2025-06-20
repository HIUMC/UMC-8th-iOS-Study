//
//  CardViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 6/16/25.
//
import Foundation
import Combine
import SwiftData
import UIKit

class CardViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var cards: [CardModel] = []
    @Published var remainingTime: Int = 180  // 3분

    private var timer: AnyCancellable?

    // ✅ SwiftData 불러오기 함수
    func loadCards(context: ModelContext) {
        isLoading = true
        do {
            let descriptor = FetchDescriptor<CardModel>(sortBy: [SortDescriptor(\.id, order: .reverse)])
            cards = try context.fetch(descriptor)
            print("✅ SwiftData에서 카드 불러옴")
        } catch {
            print("❌ 카드 로딩 실패:", error)
        }
        isLoading = false
    }

    // ✅ SwiftData에 카드 저장
    func saveCard(name: String, cardNumber: String, image: UIImage, context: ModelContext) {
        guard let imageData = image.pngData() else {
            print("❌ 이미지 PNG 변환 실패")
            return
        }

        let card = CardModel(
            id: UUID(),
            name: name,
            balance: Int.random(in: 0...9999999),
            cardNumber: cardNumber,
            imageData: imageData
        )

        context.insert(card)
        print("✅ 카드 SwiftData에 저장됨!")
    }

    // ✅ 3분 타이머
    func startTimer() {
            timer?.cancel()
            remainingTime = 180

            timer = Timer
                .publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    guard let self = self else { return }

                    if self.remainingTime > 0 {
                        self.remainingTime -= 1
                    } else {
                        self.timer?.cancel()
                    }
                }
        }
    }
