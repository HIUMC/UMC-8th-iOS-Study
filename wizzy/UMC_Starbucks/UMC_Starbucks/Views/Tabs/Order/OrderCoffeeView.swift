//
//  OrderCoffeeView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/2/25.
//

import SwiftUI

struct OrderCoffeeView: View {
    @ObservedObject var ordercoffee = OrderCoffeeViewModel()
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 23) {
                
                ForEach(ordercoffee.OrderCoffeeItem) { menu in
                    OrderCoffeeList(imageName: menu.image, coffeetitle: menu.title, coffeeEngtitle: menu.engTitle)
                    
                    

                    }
                
                
            }// lazyV
        }// scroll
    }//body
}//struct

struct OrderCoffeeList: View {
        let imageName: String
        let coffeetitle: String
    let coffeeEngtitle: String

        var body: some View {
            HStack() {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.horizontal, 13)
                
                VStack(alignment: .leading ,spacing: 10) {
                    Text(coffeetitle)
                        .font(.PretendardSemiBold14)
                        .foregroundStyle(Color.black02)
                        .multilineTextAlignment(.center)
                        .kerning(-0.42)
                    
                    Text(coffeeEngtitle)
                        .font(.PretendardSemiBold12)
                        .foregroundStyle(Color.gray03)
                        .multilineTextAlignment(.center)
                        .kerning(-0.42)
                }
                //.frame(width: 110)
            }
        }
}



#Preview {
    OrderCoffeeView()
}

