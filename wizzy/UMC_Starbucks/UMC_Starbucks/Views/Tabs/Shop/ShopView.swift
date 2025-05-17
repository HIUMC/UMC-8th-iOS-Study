//
//  ShopView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/2/25.
//

import SwiftUI

struct ShopView: View {
    @StateObject var shopAllprodViewModel: ShopAllprodViewModel = ShopAllprodViewModel()
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    shopTopBanner()
                        .padding(.top, 30)
                    allProductsView()
                        .padding(.top, 30)
                    BestItemsView()
                        .padding(.top, 30)
                    NewProductsView()
                        .padding(.top, 30)
                }
                
            }
        }
    }//body
    
    //상단 배너 스크롤뷰
    private func shopTopBanner() -> some View {
        ScrollView(.horizontal) {
            VStack (alignment: .leading) {
                Text("Starbucks Online Store")
                    .font(.PretendardBold24)
                    .padding(.bottom, 16)
                    //.padding(.horizontal, 10)
                LazyHStack(spacing: 28, content:  {
                    Image("shopTopBanner1")
                    Image("shopTopBanner2")
                    Image("shopTopBanner3")
                })
                .padding(.top, 16)
            }
        }
        .frame(height: 230)
        .padding(.horizontal, 16)
        
    } // shopTopBanner
    
    
    
    //All Products 스크롤뷰
    private func allProductsView() -> some View {
        VStack(alignment: .leading) {
            Text("All Products")
                .font(.PretendardSemiBold22)
                .foregroundStyle(Color.black03)
                .kerning(-0.5)
            
            
            ScrollView(.horizontal) {
                    
                    LazyHStack(spacing: 17) {
                        ForEach(shopAllprodViewModel.shopAllprodList) { prod in
                            CircleShopImageCard(
                                imageName: prod.imageName, prodTitle: prod.prodName)
                        }
                    } //lazyH
                }
                .frame(height: 110)
                
            }
            .padding(.horizontal, 16)
        }
        
        
        
    }// struct


#Preview {
    ShopView()
}
