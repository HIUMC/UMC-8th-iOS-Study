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
    
    let viewModel: ShopViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 44) {
                starbucksOnlineStore
                
                allProducts
                
                bestItems
                
                newProducts
            }
        }
        .padding(.horizontal, 16)
        .background(.white01)
    }
    
    // 스타벅스 온라인 샵 배너
    private var starbucksOnlineStore: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Starbucks Online Store")
                .font(.mainTextBold24)
                .foregroundStyle(.black)
            
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
        .padding(.top, 27)
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
}

#Preview {
    ShopView()
}
