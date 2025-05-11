//
//  ShopView.swift
//  Starbucks
//
//  Created by 김영택 on 3/29/25.
//

import SwiftUI

struct ShopView: View {
    
    @StateObject var viewModel = ShopViewModel()
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20) {
                OnlineStoreView
                AllProductImageView()
                BestItemsView()
                NewProductsView()
            }
        }
    }
    
    
    private var OnlineStoreView: some View {
        VStack(alignment: .leading){
            Text("Starbucks Online Store")
                .font(.PretendardBold24)
            Spacer().frame(height: 16)
            ScrollView(.horizontal){
                HStack(spacing:28){
                    ForEach(viewModel.onlinestores, id: \.self) {menu in
                        VStack{
                            Image(menu.oimageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 270, height: 216)
                                .clipped()
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        
    }//OnlineStoreView End
}
        

#Preview {
    ShopView()
}
