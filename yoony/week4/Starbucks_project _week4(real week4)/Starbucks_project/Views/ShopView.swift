//
//  ShopView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/27/25.
//

import SwiftUI

struct ShopView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let viewModel: ShopViewModel = .init()
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 44){
                bannerView
                
                allProductsView
                
                bestItemsView
                
                newProductsView
            }
        }.padding(.horizontal, 16)
        .scrollIndicators(.hidden)
        
    }
    
    private var bannerView: some View {
        VStack(alignment: .leading, spacing: 19){
            Text("Starbucks Online Store")
                .font(.PretendardBold24)
                .foregroundStyle(.black01)
            
            ScrollView(.horizontal){
                LazyHStack{
                    Image(.banner1)
                        .resizable()
                        .frame(width: 270, height: 216)
                    Image(.banner2)
                        .resizable()
                        .frame(width: 270, height: 216)
                    Image(.banner3)
                        .resizable()
                        .frame(width: 270, height: 216)
                }
            }.scrollIndicators(.hidden)
            
        }
        
    }
    
    private var allProductsView: some View {
        VStack(alignment: .leading, spacing: 19){
            Text("All Products")
                .font(.PretendardSemiBold22)
                .foregroundStyle(.black03)
            
            ScrollView(.horizontal){
                LazyHStack{
                    Image(.product1)
                        .resizable()
                        .frame(width: 80, height: 108)
                    Image(.product2)
                        .resizable()
                        .frame(width: 80, height: 108)
                    Image(.product3)
                        .resizable()
                        .frame(width: 80, height: 108)
                    Image(.product4)
                        .resizable()
                        .frame(width: 80, height: 108)
                    Image(.product5)
                        .resizable()
                        .frame(width: 80, height: 108)
                    Image(.product6)
                        .resizable()
                        .frame(width: 80, height: 108)
                    
                }
                
            }.scrollIndicators(.hidden)
        }
        
    }
    
    private var bestItemsView: some View {
        VStack{
            Text("Best Items")
                .font(.PretendardSemiBold22)
                .foregroundStyle(.black03)
            

            TabView {
                ForEach(0..<viewModel.images.count/4, id: \.self) { pageIndex in
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(0..<4, id: \.self) { index in
                                    let imageName = viewModel.images[pageIndex * 4 + index]
                                    Image(imageName)
                                        .resizable()
                                        .frame(width: 157, height: 208)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
            .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(height: 541)
            
        }
        
    }
    
    private var newProductsView: some View {
        
        VStack(alignment: .leading, spacing: 19){
            Text("New Products")
                .font(.PretendardSemiBold22)
                .foregroundStyle(.black03)
            
           
            
            LazyVGrid(columns: columns, spacing: 19){
                ForEach(viewModel.newproduct, id: \.self) { imageName in Image(imageName)
                        .resizable()
                        .frame(width: 157, height: 208)
                }
            }
            .padding(.horizontal,19)
        }
        
    }
}

#Preview {
    ShopView()
}
