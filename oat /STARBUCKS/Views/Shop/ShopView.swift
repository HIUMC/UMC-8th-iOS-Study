//
//  ShopView.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/4/25.
//

import SwiftUI

struct ShopView: View {
    @State private var show: Bool = true
    var body: some View {
        VStack(alignment: .leading){
            Text("Starbucks Online Store")
                .foregroundStyle(Color.black03)
                .font(.mainTextBold24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            ScrollView{
                Banner2View()
                Spacer()
                    .frame(height:36)
                Text("All Products")
                    .font(.mainTextSemibold22)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                AllView()
                Spacer()
                    .frame(height:36)
                Text("Best Items")
                    .font(.mainTextSemibold22)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                BestView()
                Spacer().frame(height:60)
                
                Text("New Products")
                    .font(.mainTextSemibold22)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                
                NewView()

                
            }
        }
        .fullScreenCover(isPresented: $show) {
            AdvertiseView()
        }
        .background(Color.white00)
    }
}

#Preview {
    ShopView()
}
