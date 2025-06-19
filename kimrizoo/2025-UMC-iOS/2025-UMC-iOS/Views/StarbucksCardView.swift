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
    /// Since my model ID type is UUID
    @State private var activeID: UUID?
    
    var cardImages: [UIImage] {
        cards.compactMap { cardModel in
            if let data = cardModel.cardPhoto, let image = UIImage(data: data) {
                return image
            } else {
                return UIImage(named: "starbucksCard")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomCarousel(
                    config: .init(hasOpacity: true, hasScale: true, cardWidth: 200, minimumCardWidth: 30), selection: $activeID, data: cardImages.map { ImageItem(image: $0) }
                ) { item in
                    Image(uiImage: item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    
                }
                .frame(height: 180)

            }
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
        }
    }
}

/// Custom View
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
