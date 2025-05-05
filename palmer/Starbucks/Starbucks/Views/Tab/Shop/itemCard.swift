//
//  productCard.swift
//  Starbucks
//
//  Created by 박정환 on 4/7/25.
//

import SwiftUI

struct ItemCard: View {
    let item: ItemModel
        
    init(item: ItemModel) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            item.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 157, height: 156)
                .padding(.bottom, 12)
            
      
            Text(item.title)
            .font(.pretendardSemiBold(14))
            .foregroundColor(.black02)
        }
    }
}

#Preview {
    ItemCard(item: ItemModel(image: Image("newProduct1"), title: "그린 사이렌 도트 머그"))
}
