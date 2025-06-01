//
//  ShopView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import SwiftUI

struct ShopView: View {
    
    @State private var viewModel = ShopViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 15) {
                
                BannerView()
                AllProductsView()
                BestItemView()
                NewProductsView()
                
            } // VStack (ShopView) 끝
            .padding(.horizontal,10)
        } // ScrollView (ShopView) 끝
    } // body (ShopView) 끝
} // ShopView 끝

struct BannerView: View {
    var viewModel: ShopViewModel = ShopViewModel()

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                
                // Starbucks Online Store
                Text("Starbucks Online Store")
                    .font(.PretendardSemiBold24)
                    .foregroundStyle(Color.black)
                
                Spacer()
                    .frame(height: 5)
                
                // 배너 가로 스크롤뷰
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 28) {
                        ForEach(viewModel.Banners) { desert in
                            Image(desert.imageName)
                                .resizable()
                                .scaledToFit()
                        } // ForEach (배너 이미지) 끝
                    } // HStack (배너) 끝
                } // ScrollView (배너) 끝
            } // VStack (BannerView) 끝
        } // ScrollView (BannerView) 끝
    } // body (BannerView) 끝
} // BannerView 끝

struct AllProductsView: View {
    var viewModel: ShopViewModel = ShopViewModel()
    
    var body: some View {
        // All products
        Text("All products")
            .font(.PretendardSemiBold24)
            .foregroundStyle(Color.black)
        
        Spacer()
        
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                ForEach(Array(viewModel.Products.enumerated()), id: \.element) { index, item in
                    CircleImageCard(imageName: item.imageName, title: item.title, imageSize: 80)
                } // ForEach (All Products) 끝
            } // LazyHStack 끝
        } // ScrollView (All Products) 끝
    } // body (AllProductsView) 끝
} // AllProductsView 끝

struct BestItemView: View {
    @State private var currentPage = 0
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var viewModel: ShopViewModel = ShopViewModel()
    
    var body: some View {
        Text("Best Items")
            .font(.PretendardSemiBold24)
            .foregroundStyle(Color.black)
        
        TabView(selection: $currentPage) {
            ForEach(0..<2, id: \.self) { pageIndex in
                LazyVGrid(columns: columns, spacing: 55) {
                    ForEach(0..<4, id: \.self) { i in
                        let itemIndex = pageIndex * 4 + i
                        
                        // Index 범위 보호
                        if itemIndex < viewModel.BestItems.count {
                            let item = viewModel.BestItems[itemIndex]
                            CircleImageCard(imageName: item.imageName, title: item.title, imageSize: 150)
                        } // if (Index 체크) 끝
                    } // ForEach (4개씩) 끝
                } // LazyVGrid 끝
                .tag(pageIndex)
            } // ForEach (페이지 2개) 끝
        } // TabView 끝
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 520)
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray
        } // onAppear 끝
    } // body (BestItemView) 끝
} // BestItemView 끝

struct NewProductsView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var viewModel: ShopViewModel = ShopViewModel()
    
    var body: some View {
        Text("New Products")
            .font(.PretendardSemiBold24)
            .foregroundStyle(Color.black)
        
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(viewModel.NewProducts, id: \.id) { item in
                CircleImageCard(imageName: item.imageName, title: item.title, imageSize: 150)
            } // ForEach (New Products) 끝
        } // LazyVGrid (New Products) 끝
    } // body (NewProductsView) 끝
} // NewProductsView 끝

#Preview {
    ShopView()
}
