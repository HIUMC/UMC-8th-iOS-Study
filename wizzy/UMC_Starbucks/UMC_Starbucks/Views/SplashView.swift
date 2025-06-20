//
//  SplashView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI
import SwiftData

struct SplashView: View {
    @Environment(\.modelContext) private var context
    @Query var cards: [CardModel]
    @State private var isActive = false
    @State private var AutoLogin = false
    var body: some View {
        NavigationStack {
            Group {
                ZStack(alignment: .center) {
                    Color.loginButtonGreen.ignoresSafeArea(.all)
                    VStack {
                        Image("Starbucks")
                        // sfsymbol 이미지가 아니면, Resizable 없이는 크기조정 불가
                            .resizable()
                            .frame(width: 168, height: 168)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                }
            }
            .opacity(isActive ? 0 : 1)
            .animation(.easeOut(duration: 1), value: isActive)
            .onAppear {
                print("✅ 카드 수: \(cards.count)") // log card count to debug console
                // ✅ OSRM_BASE_URL 출력 확인
                if let urlString = Bundle.main.object(forInfoDictionaryKey: "OSRM_BASE_URL") as? String {
                    print("✅ SplashView에서 baseURL 확인됨: \(urlString)")
                } else {
                    print("❌ SplashView에서 baseURL을 못 찾음")
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if let token = KeychainService.shared.loadTokenInfo() {
                        print("자동 로그인: \(token.accessToken)")
                        AutoLogin = true
                        UserDefaults.standard.set(token.nickname, forKey: "nickname") // gpt
                    }
                    withAnimation {
                        isActive = true
                    }
                }
            }
            .task {
                do {
                    let existing = try context.fetch(FetchDescriptor<CardModel>())
                    if existing.isEmpty {
                        let sample = [
                            CardModel(
                                imageName: "cardImage",
                                cardName: "아무카드 A",
                                cardMoney: 1000,
                                cardNumber: "1234-5678-1234-5678",
                                activationDate: Date()
                            ),
                            CardModel(
                                imageName: "cardImage",
                                cardName: "아무카드 B",
                                cardMoney: 2500,
                                cardNumber: "8765-4930-1122-3344",
                                activationDate: Date()
                            ),
                            CardModel(
                                imageName: "cardImage",
                                cardName: "아무카드 C",
                                cardMoney: 250000,
                                cardNumber: "8733-4930-1122-1484",
                                activationDate: Date()
                            )
                        ]
                        for card in sample {
                            context.insert(card)
                        }
                        try context.save()
                        print("✅ 샘플 카드 3개 삽입 완료")
                    } else {
                        print("⚠️ 기존 카드 데이터 존재 - 삽입 생략 (총 \(existing.count)개)")
                    }
                } catch {
                    print("❌ 카드 샘플 데이터 삽입 실패: \(error)")
                }
            }
            .navigationDestination(isPresented: $isActive) {
                if AutoLogin {
                    TabBarView()
                } else {
                    LoginView()
                }
            }
        }
    }
}


#Preview {
    SplashView()
}
