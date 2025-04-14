//
//  ShopView.swift
//  Starbucks
//
//  Created by nau on 4/7/25.
//

import SwiftUI

struct ShopView: View {
    @State var viewModel: ShopViewModel = .init()
    
    /*let columns =  [
        GridItem(.adaptive(minimum: 140, maximum: 160), spacing: 25),
        GridItem(.adaptive(minimum: 140, maximum: 160), spacing: 25)
    ]*/
    
    //Array(repeating: count: )이용해서
    let columns = Array(repeating: GridItem(.adaptive(minimum: 140, maximum: 160), spacing: 25), count: 2)
    
    var body: some View {
        ZStack {
            Color(.white01).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 44) {
                    topBannerView
                    
                    allProductsView
                    
                    bestItemView
                    
                    newProductsView
                }
            }.padding(.horizontal, 16)
        }
    }
    
    private var topBannerView: some View {
        VStack(alignment: .leading) {
            Text("Starbucks Online Store")
                .font(.mainTextBold24)
                .foregroundStyle(.black)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(viewModel.shopBannerViewModel) { model in
                        Image(model.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 270)
                    }
                }
            }.scrollIndicators(.hidden)
        }
    }
    
    private var allProductsView: some View {
        VStack(alignment: .leading) {
            Text("All Products")
                .font(.mainTextSemibold22)
                .foregroundStyle(.black03)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(viewModel.allProductsViewModel) { model in
                        VStack {
                            Image(model.image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                            
                            Text(model.name)
                                .font(.mainTextSemibold13)
                                .foregroundStyle(.black)
                        }
                    }
                }
            }.scrollIndicators(.hidden)
            
        }
    }
    
    private var bestItemView: some View {
        
        return VStack(alignment: .leading) {
            Text("Best Items")
                .font(.mainTextSemibold22)
                .foregroundStyle(.black03)
            
            
            TabView {
                ForEach(0..<viewModel.bestItemViewModel.count / 4) { index in
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<4) { i in
                            let model = viewModel.bestItemViewModel[index * 4 + i]
                            rectangleImageCard(model)
                        }
                    }.padding(.bottom, 50)
                }
            }.onAppear() {
                setIndicator()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(minHeight: 500)
                .indexViewStyle(PageIndexViewStyle())

        }
    }
    
    private var newProductsView: some View {
        VStack(alignment: .leading) {
            Text("New Products")
                .font(.mainTextSemibold22)
                .foregroundStyle(.black03)
            
            LazyVGrid(columns: columns) {
                ForEach(viewModel.newProductViewModel) { model in
                    rectangleImageCard(model)
                }
            }
        }
    }
    
    private func rectangleImageCard(_ model: RecommendMenuModel) -> some View {
        VStack(alignment: .leading) {
            Image(model.image)
                .resizable()
                .scaledToFit()
            
            Text(model.name.splitChar())
                .font(.mainTextSemibold13)
                .foregroundStyle(.black)
                .frame(height: 35)
        }

    }
    
    //UIKit 사용!! 도트 선 색은 못했음..
    private func setIndicator() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.black03)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.white)
    }
}
    

#Preview {
    ShopView()
}
