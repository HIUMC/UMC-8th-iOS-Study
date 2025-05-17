//
//  ShopVview.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/8/25.
//

import SwiftUI

struct ShopView: View {
    @State private var viewModel: ShopViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("Starbucks Online Store")
                    .font(.mainTextBold24)
                    .foregroundStyle(Color("black00"))
                    .padding(EdgeInsets(top: 72, leading: 16, bottom: -16, trailing: 16))
                banner
                allProducts
                bestItems
                newProducts
            }
        }
        .scrollIndicators(.hidden)
        .toolbarVisibility(.hidden)
        .ignoresSafeArea()
        .background(Color("white01"))
    }
    
    private var banner: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 28) {
                ForEach(viewModel.banners) { banner in
                    Image(banner.img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 270, height: 216)
                }
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden)
    }
    
    private var allProducts: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("All Products")
                .font(.mainTextSemiBold24)
                .foregroundStyle(Color("black03"))
                .padding(.leading, 16)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.allProducts) { product in
                        allProductCard(img: product.img, name: product.name)
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    private func allProductCard(img: String, name: String) -> some View {
        VStack(spacing: 10) {
            Image(img)
                .resizable()
                .frame(width: 80, height: 80)
            
            Text(name)
                .font(.mainTextSemiBold13)
                .foregroundStyle(Color("black02"))
        }
    }
    
    @State private var currentPage: Int = 0
    
    private var bestItems: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Best Items")
                .font(.mainTextSemiBold24)
                .foregroundStyle(Color("black03"))
                .padding(.leading, 16)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 64) {
                    ForEach(0..<2) { index in
                        LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: 32), count: 2), alignment: .top, spacing: 64) {
                            ForEach(viewModel.bestItems[index]) {
                                product in productCard(img: product.img, name: product.name)
                            }
                            
                        }
                        .id(index)
                    }
                }
                .padding(.horizontal, 32)
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            
            HStack {
                Spacer()
                ForEach(0..<2) { index in
                    Circle()
                        .fill(currentPage == index ? Color("green01") : Color("gray05"))
                        .frame(width: 8, height: 8)
                }
                Spacer()
            }
        }
    }
    
    private var newProducts: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("New Products")
                .font(.mainTextSemiBold24)
                .foregroundStyle(Color("black03"))
                .padding(.leading, 16)
            
            LazyHGrid(rows: Array(repeating: GridItem(.fixed(208), spacing: 32), count: 2), alignment: .top, spacing: 64) {
                ForEach(viewModel.newProducts) {
                    product in productCard(img: product.img, name: product.name)
                }
            }
            .padding(.horizontal, 32)
        }
    }
    
    private func productCard(img: String, name: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(img)
                .resizable()
                .frame(width: 156, height: 156)
            
            Text(name)
                .font(.mainTextSemiBold14)
                .foregroundStyle(Color("black02"))
        }
        .frame(width: 156)
    }
}

#Preview {
    ShopView()
}
