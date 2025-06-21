//
//  ShopView.swift
//  Starbucks
//
//  Created by 박정환 on 3/31/25.
//

import SwiftUI

struct ShopView: View {
    let ItemColumns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var currentPage = 0
    @State private var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    let viewModel: ShopViewModel = .init()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                headerView()

                LazyVStack(alignment: .leading, spacing: 44, pinnedViews: [.sectionHeaders]) {
                    Section(header: pinnedHeaderView()
                                .modifier(OffsetModifier(offset: $headerOffsets.0, returnromStart: false))
                                .modifier(OffsetModifier(offset: $headerOffsets.1))) {
                        VStack(spacing: 44) {
                            starbucksOnlineStore
                            allProducts
                            bestItems
                            newProducts
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
        .coordinateSpace(name: "SCROLL")
        .background(Color.white01)
    }
    
    // 스타벅스 온라인 샵 배너
    private var starbucksOnlineStore: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: 28, content: {
                ForEach(1...3, id: \.self) { rowIndex in
                    Image("shopBanner\(rowIndex)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 270, height: 215)
                }
            })
        })
        .scrollIndicators(.hidden)
    }
    
    // 모든 상품(가로 스크롤)
    private var allProducts: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("All Products")
                .font(.pretendardSemiBold(22))
                .foregroundStyle(.black03)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 17) {
                    ForEach(viewModel.dummyProducts, id: \.id) { product in
                        ItemCard(item: product)
                    }
                }
            }
        }
    }
    
    // 베스트 아이템(가로 화면 2개)
    private var bestItems: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Best Items")
                .font(.pretendardSemiBold(22))
                .foregroundStyle(.black03)
            
            TabView(selection: $currentPage) {
                ForEach(0..<2, id: \.self) { pageIndex in
                    LazyVGrid(columns: ItemColumns, spacing: 55) {
                        ForEach(0..<4, id: \.self) { i in
                            let itemIndex = pageIndex * 4 + i
                            let item = viewModel.dummyBestItems[itemIndex]
                            
                            ItemCard(item: item)
                        }
                    }
                }
                .padding(.bottom, 60)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 510)
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black03
                UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray02
            }
        }
    }
    
    
    // 신제품
    private var newProducts: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("New Products")
                .font(.pretendardSemiBold(22))
                .foregroundStyle(.black03)
            
            LazyVGrid(columns: ItemColumns, spacing: 30) {
                ForEach(viewModel.dummyNewProducts, id: \.id) { item in
                    ItemCard(item: item)
                }
            }
            .frame(height: 450)
        }
    }
    
    private func headerView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = max(0, size.height + minY)

            Rectangle()
                .fill(Color.white)
                .frame(width: size.width, height: height, alignment: .top)
                .offset(y: -minY)
        }
        .frame(height: 20)
    }

    private func pinnedHeaderView() -> some View {
        let threshold = -(getScreenSize().height * 0.05)

        return HStack {
            if headerOffsets.0 < threshold {
                Spacer()
            }

            Text("Starbucks Online Store")
                .font(headerOffsets.0 < threshold ? .mainTextBold24 : .pretendardSemiBold(20))
                .foregroundStyle(.black)
                .animation(.easeInOut(duration: 0.4), value: headerOffsets.0)

            Spacer()
        }
        .frame(height: 90, alignment: .bottomLeading)
        .safeAreaPadding(.bottom, headerOffsets.0 < threshold ? 20 : 0)
        .background(Color.white)
    }
}

#Preview {
    ShopView()
}

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    var returnromStart: Bool = true

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            offset = value
                        }
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

func getScreenSize() -> CGSize {
    UIScreen.main.bounds.size
}
