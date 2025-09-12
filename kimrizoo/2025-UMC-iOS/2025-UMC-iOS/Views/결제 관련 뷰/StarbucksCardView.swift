//
//  StarbucksCardView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 6/18/25.
//

import SwiftUI
import SwiftData

struct StarbucksCardView: View {
    @Environment(\.modelContext) private var context
    @Query private var cards: [StarbucksCardModel]
    @State private var isPresentingSheet = false
    @State private var activeID: UUID?
    
    // 타이머 관련 변수
    @State private var timeOverAlert: Bool = false
    @State private var remainingTime: Int = 180
    @State private var timerTask: Task<Void, Never>? = nil
    @State private var timerID: UUID = UUID()
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomCarousel(
                    config: .init(hasOpacity: true, hasScale: true, cardWidth: 272, minimumCardWidth: 30),
                    selection: $activeID,
                    data: cards
                ) { card in
                    cardView(card)
                }
                .frame(height: 400)
                .onChange(of: activeID) {
                    startTimer()
                }
                
                if cards.first(where: { $0.id == activeID }) != nil {
                    Text("남은 시간: \(remainingTime / 60)분 \(remainingTime % 60)초")
                        .font(.caption)
                }
                
            }
            // MARK: - 네비게이션
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Pay")
                        .font(.customPretend(.medium, size: 24))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentingSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                    }
                }
            }
            .sheet(isPresented: $isPresentingSheet) {
                StarbucksCardCreatingView(isPresented: $isPresentingSheet, cardName: "", cardNumber: "")
            }
            .alert("3분이 만료되었습니다.", isPresented: $timeOverAlert) {
                Button("확인", role: .cancel) {}
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timerTask?.cancel()
            }
        }
    }
    
    // MARK: - 카드 뷰 (중앙의 카드만 카드 정보가 보이게 처리)
    @ViewBuilder
    private func cardView(_ card: StarbucksCardModel) -> some View {
        VStack(spacing: 0) {
            cardImage(for: card)
                .frame(height: 143)
                .cornerRadius(10)
            
            Spacer().frame(height: 23)
            
            cardInfo(for: card)
                .opacity(card.id == activeID ? 1 : 0)
                .animation(.easeIn(duration: 0.3), value: activeID)
        }
    }
    
    // MARK: - 카드 이미지 처리 (data->UIImage로)
    @ViewBuilder
    private func cardImage(for card: StarbucksCardModel) -> some View {
        if let data = card.cardPhoto, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image("starbucksCard")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
    
    // MARK: - 카드정보를 스위프트 데이터에서 받아옴
    @ViewBuilder
    private func cardInfo(for card: StarbucksCardModel) -> some View {
        Group {
            Text(card.cardName)
                .font(.customPretend(.medium, size: 13))
                .foregroundStyle(.advertisementBlack)
            
            Text("잔액: \(card.balance)원")
                .font(.customPretend(.medium, size: 18))
            
            Spacer().frame(height: 23)
            
            Text("카드번호: \(maskedCardNumber(card.cardNumber))")
                .font(.customPretend(.medium, size: 12))
                .foregroundColor(.customBlackColor)
            
            Spacer().frame(height: 8)
            
            HStack {
                Text("카드 유효 시간")
                    .font(.customPretend(.medium, size: 12))
                    .foregroundStyle(.customGray2)
            }
        }
    }
    
    // 카드 넘버 마스크 함수
    private func maskedCardNumber(_ number: Int) -> String {
        // Int를 String으로 변환
        var numberString = String(number)
        
        // 12자리가 되도록 앞에 '0' 추가 (패딩)
        while numberString.count < 12 {
            numberString = "0" + numberString
        }
        
        let suffix = numberString.suffix(4)
        return "****-****-\(suffix)"
    }

    
    /// 3분 타이머 비동기 함수
    ///  카드 스크롤의 activeID가 변경되면 타이머가 재시작 한다.
    ///  3분이 만료되면 Alert을 띄운다.
    private func startTimer() {
        // 타이머 초기화
        timerTask?.cancel()
        remainingTime = 180
        
        timerTask = Task {
            await runTimer()
        }
    }

    private func runTimer() async {
        while true {
            try? await Task.sleep(nanoseconds: 1_000_000_000)

            // Task가 cancel 되었으면 빠져나감
            if Task.isCancelled { return }

            await MainActor.run {
                remainingTime -= 1

                if remainingTime <= 0 {
                    timeOverAlert = true
                    timerTask?.cancel()  // 명시적으로 종료
                }
            }
        }
    }

}

// MARK: - CustomCarousel
struct CustomCarousel<Content: View, Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    var config: Config
    @Binding var selection: Data.Element.ID?
    var data: Data
    @ViewBuilder var content: (Data.Element) -> Content
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ScrollView(.horizontal) {
                HStack(spacing: config.spacing) {
                    ForEach(data) { item in
                        ItemView(item)
                    }
                }
                .scrollTargetLayout()
            }
            /// Making it to start and end at the center
            .safeAreaPadding(.horizontal, max((size.width - config.cardWidth) / 2, 0))
            .scrollPosition(id: $selection)
            /// Making it a carousel
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            /// Hiding Scroll Indicator
            .scrollIndicators(.hidden)
        }
    }
    
    /// Item View
    @ViewBuilder
    func ItemView(_ item: Data.Element) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            let progress = minX / (config.cardWidth + config.spacing)
            let minimumCardWidth = config.minimumCardWidth
            
            let diffWidth = config.cardWidth - minimumCardWidth
            let reducingWidth = progress * diffWidth
            // Limiting diffWidth as the Max Value
            let cappedWidth = min(reducingWidth, diffWidth)
            
            let resizedFrameWidth = size.width - (minX > 0 ? cappedWidth : min(-cappedWidth, diffWidth))
            let negativeProgress = max(-progress, 0)
            
            let scaleValue = config.scaleValue * abs(progress)
            let opacityValue = config.opacityValue * abs(progress)
            
            content(item)
                .frame(width: size.width, height: size.height)
                .frame(width: resizedFrameWidth)
                .opacity(config.hasOpacity ? 1 - opacityValue : 1)
                .scaleEffect(config.hasScale ? 1 - scaleValue : 1)
                .mask {
                    let hasScale = config.hasScale
                    let scaledHeight = (1 - scaleValue) * size.height
                    RoundedRectangle(cornerRadius: config.cornerRadius)
                        .frame(height: hasScale ? max(scaledHeight, 0) : size.height)
                }
                .offset(x: -reducingWidth)
                .offset(x: min(progress, 1) * diffWidth)
                .offset(x: negativeProgress * diffWidth)
        }
        .frame(width: config.cardWidth)
    }
    
    /// Config
    struct Config {
        var hasOpacity: Bool = false
        var opacityValue: CGFloat = 0.4
        var hasScale: Bool = false
        var scaleValue: CGFloat = 0.2
        
        var cardWidth: CGFloat = 150
        var spacing: CGFloat = 10
        var cornerRadius: CGFloat = 15
        var minimumCardWidth: CGFloat = 40
    }
}

#Preview {
    StarbucksCardView()
}
