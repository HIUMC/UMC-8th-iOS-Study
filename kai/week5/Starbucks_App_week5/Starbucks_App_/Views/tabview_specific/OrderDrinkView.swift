//
//  OrderDrinkView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/4/25.
//

import SwiftUI

struct OrderDrinkView: View {
    @Environment(OrderViewModel.self) var viewModel
    
    var body: some View {
        VStack(alignment: .center){
            LazyView
        }

    }
    
    private var LazyView: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 23) {
                ForEach(viewModel.orderDrinkViewModel) { model in
                    orderDrinkCard(model)
                }
            }
        }
        .frame(
            minWidth: UIScreen.main.bounds.width - 46,
            maxWidth: UIScreen.main.bounds.width - 40
        )

        .scrollIndicators(.hidden)
    }
    
    private func orderDrinkCard(_ model: OrderModel) -> some View {
        HStack(spacing: 10) {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 60, maxHeight: 60)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 2) {
                    Text(model.name)
                        .font(.PretendardSemiBold16)
                        .foregroundStyle(.gray)
               
                        Circle()
                        .fill(model.showCircle ? Color.tabGreen : Color.white)
                        .frame(maxWidth: 6, maxHeight: 6)
                    
                }
                
                Text(model.enName)
                    .font(.PretendardRegular13)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    OrderDrinkView()
        .environment(OrderViewModel())
}
