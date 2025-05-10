//
//  OrderFoodView.swift
//  Starbucks
//
//  Created by nau on 5/1/25.
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
        .frame(minWidth: UIScreen.screenSize.width - 46, maxWidth: UIScreen.screenSize.width - 40)
        .scrollIndicators(.hidden)
    }
    
    private func orderDrinkCard(_ model: OrderDrinkModel) -> some View {
        HStack(spacing: 10) {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 60, maxHeight: 60)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 2) {
                    Text(model.name)
                        .font(.mainTextSemibold16)
                        .foregroundStyle(.gray06)
               
                        Circle()
                        .fill(model.showCircle ? Color.green01 : Color.white)
                        .frame(maxWidth: 6, maxHeight: 6)
                    
                }
                
                Text(model.enName)
                    .font(.mainTextSemibold13)
                    .foregroundStyle(.gray03)
            }
        }
    }
}

#Preview {
    OrderDrinkView()
}
