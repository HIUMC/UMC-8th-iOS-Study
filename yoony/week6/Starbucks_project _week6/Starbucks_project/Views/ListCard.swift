//
//  ListCard.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//

import SwiftUI

struct ListCard: View {
    
    let model: MenuDisplayable
    
    init(model: MenuDisplayable) {
        self.model = model
    }
    
    var body: some View {
        HStack {
            
            model.image
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.trailing, 16)
            
            VStack(alignment: .leading) {
                Text(model.Korname)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(.grey06)
                    .padding(.bottom, 4)
                
                Text(model.ENname)
                    .font(.mainTextSemiBold13)
                    .foregroundStyle(.grey03)
            }
            Spacer()
        }
        .padding(23)
        
        

    }
}

#Preview {
    ListCard(model: CoffeeMenuListModel(ENname: "Recommend", Korname: "추천", image: Image("c1")))
}
