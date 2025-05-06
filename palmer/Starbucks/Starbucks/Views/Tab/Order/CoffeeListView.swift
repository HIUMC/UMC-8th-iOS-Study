//
//  CoffeeListView.swift
//  Starbucks
//
//  Created by 박정환 on 5/6/25.
//

import SwiftUI

struct CoffeeListView: View {
    let model: OrderCoffeeModel
    
    init(model: OrderCoffeeModel) {
        self.model = model
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(model.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                ZStack(alignment: .topTrailing) {
                    Text(model.name)
                        .foregroundStyle(.gray06)
                        .font(.pretendardSemiBold(16))
                    
                    Circle()
                        .fill(.green01)
                        .frame(width: 6, height: 6)
                        .offset(x: 7, y: -2)
                }
                
                Text(model.nameEn)
                    .foregroundStyle(.gray03)
                    .font(.pretendardSemiBold(13))
            }
        
            Spacer()
        }
    }
}
