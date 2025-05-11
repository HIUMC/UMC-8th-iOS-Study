//
//  ShopView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct ShopView: View {
    @Bindable private var viewModel: ShopViewModel = .init()
    let columns = Array(repeating: GridItem(.flexible(), spacing: 65), count: 2)

    var body: some View {
        ZStack {
            Color.white01
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 36) {
                    onlineStore
                    allProducts
                    bestItems
                    newProducts
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .ignoresSafeArea()
        
    }
    
    private var onlineStore: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Starbucks Online Store")
                    .font(.MainTextBold24)
                    .foregroundStyle(.black)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.onlineStores, id: \.self) { banner in
                        Image(banner.imageName)
                            .resizable()
                            .frame(width: 270, height: 216)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 50)
        
    }
    
    private var allProducts: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("All Products")
                .font(.pretend(type: .semibold, size: 22))
                .foregroundStyle(.black)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.allProducts, id: \.self) { product in
                        VStack(spacing: 10) {
                            Image(product.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            Text(product.title)
                                .font(.MainTextSemiBold13)
                                .foregroundStyle(.black02)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    
    private var bestItems: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("All Products")
                .font(.pretend(type: .semibold, size: 22))
                .foregroundStyle(.black)
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(ProductPage.allCases, id: \.id) { page in
                        LazyVGrid(columns: columns, spacing: 54) {
                            ForEach(page.items(from: viewModel.bestItems), id: \.self) { item in
                                VStack(alignment: .leading, spacing: 12) {
                                    Image(item.imageName)
                                        .resizable()
                                    Group {
                                        Text(item.title)
                                        Text(item.cupSize.map { "\($0)ml" } ?? "")
                                    }
                                    .font(.MainTextSemiBold14)
                                    .foregroundStyle(.black02)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
                
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)

        }
        
        
        
    }
    
    
    private var newProducts: some View {
        VStack(spacing: 16) {
            HStack {
                Text("New Products")
                    .font(.MainTextBold24)
                    .foregroundStyle(.black)
                Spacer()
            }
            ScrollView {
                LazyVGrid(columns: columns, spacing: 54) {
                    ForEach(viewModel.newProducts, id: \.self) { item in
                        VStack(alignment: .leading, spacing: 12) {
                            Image(item.imageName)
                                .resizable()
                            Group {
                                Text(item.title)
                                Text(item.cupSize != nil ? "\(item.cupSize)ml": "")
                            }
                            .font(.MainTextSemiBold14)
                            .foregroundStyle(.black02)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        
    }
    
    
}

struct ShopView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            ShopView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
