//
//  ShopView.swift
//  Starbucks
//
//  Created by 이가원 on 4/6/25.
//
import SwiftUI
import Foundation

struct ShopView: View {
    @StateObject private var allProducts = AllProductsViewModel()
    @StateObject private var bestItemsViewModel = BestItemsViewModel()
    @State private var currentPage = 0
    @StateObject private var newItemsViewModel = NewViewModel()

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 24) {
                    Spacer().frame(height: 67)
                    banners
                    allproducts
                    bestitems
                    newproducts
                    Spacer().frame(height:71)
                }
            }

            
        }
        .background(Color .white01)
        .ignoresSafeArea()
    }

    private var banners: some View {
        VStack(alignment: .leading) {
            Text("Starbucks Online Store")
                .font(.custom("Pretendard-Bold", size: 24))
                .padding(.leading, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    Image(.variant1)
                    Image(.variant2)
                    Image(.variant3)
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.vertical, 19)
    }

    private var allproducts: some View {
        VStack(alignment: .leading) {
            Text("All Products")
                .font(.custom("Pretendard-Bold", size: 22))
                .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(allProducts.products) { product in
                        ProductCard(imageName: product.imageName, name: product.name)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    private var bestitems: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Best Items")
                .font(.custom("Pretendard-Bold", size: 22))
                .padding(.leading, 20)
                .padding(.bottom, 16)

            TabView(selection: $currentPage) {
                ForEach(bestItemsViewModel.pagedItems().indices, id: \.self) { index in
                    VStack(spacing: 0) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                            ForEach(bestItemsViewModel.pagedItems()[index], id: \.title) { item in
                                BestNewCard(imageName: item.imageName, title: item.title)
                            }
                        }
                        .padding(.horizontal, 20)

                        HStack(spacing: 6) {
                            ForEach(0..<bestItemsViewModel.pagedItems().count, id: \.self) { dotIndex in
                                Circle()
                                    .fill(currentPage == dotIndex ? Color.black : Color.gray.opacity(0.3))
                                    .frame(width: 8, height: 8)
                            }
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page)
            .frame(height: 470)
        }
    }
    private var newproducts: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("New Products")
                .font(.custom("Pretendard-Bold", size: 22))
                .padding(.leading, 20)
                .padding(.bottom, 16)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                ForEach(newItemsViewModel.newItems, id: \.title) { item in
                    BestNewCard(imageName: item.imageName, title: item.title)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
#Preview {
    ShopView()
}
