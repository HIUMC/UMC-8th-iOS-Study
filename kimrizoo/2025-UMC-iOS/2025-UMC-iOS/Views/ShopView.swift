//
//  ShopView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/9/25.
//

import SwiftUI

struct ShopView: View {
    @State private var viewModel = ShopViewModel()
    
    var body: some View {
            
            ScrollView {
                // 스토어 배너
                VStack {
                    HStack {
                        Text("Starbucks Online Store")
                            .font(.customPretend(.medium, size: 24))
                        
                        Spacer()
                    }
                    
                    Spacer().frame(height: 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 28) {
                            ForEach(1..<4) { index in Image("store_banner\(index)")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
                // 스토어 배너 끝
                
                // 모든 상품 섹션
                AllProductCategoryView(categories: viewModel.allCategories)
                
                // 베스트 아이템 섹션
                BestItemsView(bestItems: viewModel.bestItems)
                
                // 뉴 프로덕트 섹션
                NewProductsView(products: viewModel.newProducts)
            }
            .padding(.horizontal, 16)
            .background(Color.otherBackground)
    }
}

#Preview {
    ShopView()
}

// All Products 섹션
struct AllProductCategoryView: View {
    let categories: [AllProductCategoryModel]

    var body: some View {
        VStack {
            HStack {
                Text("All Products")
                    .font(.customPretend(.medium, size: 22))
                
                Spacer()
            }

            Spacer().frame(height: 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 17) {
                    ForEach(categories) { category in
                        VStack {
                            Image(category.imageName)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())

                            Text(category.title)
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
// ------------------------------------------
// 베스트 아이템즈
struct BestItemsView: View {
    let bestItems: [BestItemModel]
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State private var currentPage = 0
    
    // 1페이지에 4개씩 보여줌
    private var pagedItems: [[BestItemModel]] {
        bestItems.chunked(into: 4)
    }
    
    init(bestItems: [BestItemModel]) {
            self.bestItems = bestItems
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Best Items")
                .font(.customPretend(.medium, size: 22))
            
            TabView(selection: $currentPage) {
                ForEach(0..<pagedItems.count, id: \.self) { index in
                    LazyVGrid(columns: columns) {
                        ForEach(pagedItems[index]) { item in
                            VStack(alignment: .leading) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 157, height: 156)
                                
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.customPretend(.regular, size: 14))
                                    
                                    if !item.subtitle.isEmpty {
                                        Text(item.subtitle)
                                            .font(.customPretend(.regular, size: 14))
                                    }
                                }
                                .frame(height: 40)
                            }
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 470) // 높이 조정
        }
    }
}
// ------------------------------------------
// 뉴 프로덕트 섹션
struct NewProductsView: View {
    let products: [BestItemModel]
    
    // 2열로 그리드 정의
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        VStack {
            HStack {
                Text("New Products")
                    .font(.customPretend(.medium, size: 22))
                
                Spacer()
            }
            
            Spacer().frame(height: 16)
            
            LazyVGrid(columns: columns) {
                ForEach(products) { item in
                    VStack(alignment: .leading) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 157, height: 156)
                        
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.customPretend(.regular, size: 14))
                            
                            Text(item.subtitle)
                                .font(.customPretend(.regular, size: 14))
                        }
                        .frame(height: 40)
                    }
                }
            }
        }
    }
}
// ------------------------------------------
