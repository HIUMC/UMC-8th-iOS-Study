//
//  AllProductView.swift
//  Starbucks
//
//  Created by 김영택 on 4/10/25.
//

import SwiftUI

struct AllProductImageView: View {
    
    @StateObject var viewModel = ShopViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("All Products")
                .font(.PretendardSemibold22)
            Spacer().frame(height: 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(viewModel.allproduct, id: \.self) {menu in
                        VStack{
                            Image(menu.allProductimageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                            Spacer().frame(height: 10)
                            
                            Text(menu.allProductName)
                                .font(.PretendardSemibold13)
                        }
                    }
                }
            }
        }.padding(.leading, 20)
    }
}


#Preview {
    AllProductImageView()
}
