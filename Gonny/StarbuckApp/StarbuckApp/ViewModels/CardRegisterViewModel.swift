//
//  CardRegisterViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 6/21/25.
//
import Foundation
import Combine
import UIKit

class CardRegisterViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var cards: [Card] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func generateImage(prompt: String, negativePrompt: String) {
        isLoading = true
        errorMessage = nil
        
        ImageServiceManager.shared.generateImage(prompt: prompt, negativePrompt: negativePrompt)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] image in
                self?.image = image
            })
            .store(in: &cancellables)
    }
    
    func addCard(
        imageName: String = "creditcard", // 기본 이미지 네임(피그마 이미지 명칭)
        name: String,
        price: Int,
        cardNumber: String,
        money: Int? = nil,
        initialSeconds: Int = 180, // 3분(180초) 예시
        remainingSeconds: Int? = nil
    ) {
        let finalMoney = money ?? Int.random(in: 0...19_999_999)
        let finalRemaining = remainingSeconds ?? initialSeconds
        
        let card = Card(
            imageName: imageName,
            name: name,
            price: price,
            cardNumber: cardNumber,
            money: Int.random(in: 0...19_999_999),
            initialSeconds: initialSeconds,
            remainingSeconds: finalRemaining
        )
        // 최신순 맨 앞에 추가
        cards.insert(card, at: 0)
    }
}
// money: Int.random(in: 0...19_999_999)
