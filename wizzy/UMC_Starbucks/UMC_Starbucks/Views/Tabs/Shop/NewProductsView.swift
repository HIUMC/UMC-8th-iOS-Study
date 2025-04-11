//
//  NewProductsView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/7/25.
//

import SwiftUI

struct NewProductsView: View {

    let bestItems = [
            BestItemModel(imageName: "newImg1", itemTitle: "그린 사이렌 도트 머그", size: "237ml"),
            BestItemModel(imageName: "newImg2", itemTitle: "그린 사이렌 도트 머그", size: "355ml"),
            BestItemModel(imageName: "newImg3", itemTitle: "홈 카페 미니 머그 세트", size: ""),
            BestItemModel(imageName: "newImg4", itemTitle: "홈 카페 글라스 세트", size: "")
        ]
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("New Products")
                    .font(.PretendardSemiBold22)
                    
                
                bestItemGrid(items: bestItems)
            }
            .padding(.horizontal, 10)
        }

    @ViewBuilder
    func bestItemGrid(items: [BestItemModel]) -> some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 65), GridItem(.flexible(), spacing: 65)], spacing: 65) {
            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 10) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 157, height: 156)
                        .background(Color.white)
                        .cornerRadius(5)
                    
                    VStack(alignment: .leading) {
                        Text(item.itemTitle)
                        Text(item.size)
                    }
                    .font(.PretendardSemiBold14)
                    .foregroundStyle(Color.black03)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    
}






#Preview {
    NewProductsView()
}
