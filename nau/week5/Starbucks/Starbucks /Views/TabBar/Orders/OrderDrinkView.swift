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
        VStack {
            LazyView
        }
    }
    
    private var LazyView: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.orderDrinkViewModel) { model in
                    orderDrinkCard(model)
                }
            }
        }
    }
    
    private func orderDrinkCard(_ model: OrderDrinkModel) -> some View {
        VStack {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 130, maxHeight: 130)
            
            Spacer().frame(height: 10)
            
            Text(model.name)
                .font(.mainTextSemibold14)
                .foregroundStyle(.black02)
        }
    }
}

#Preview {
    OrderDrinkView()
}
