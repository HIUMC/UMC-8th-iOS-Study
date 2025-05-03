//
//  OrderCircleImage.swift
//  Starbucks
//
//  Created by 김영택 on 5/2/25.
//

import SwiftUI

struct OrderCircleImage: View {
    @StateObject var viewModel = OrderViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack( alignment: .leading, spacing: 26) {
                ForEach(viewModel.orderproduct, id: \.self) {menu in
                    HStack{
                        Image(menu.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipped()
                        Spacer().frame(width: 16)
                        VStack(alignment: .leading){
                            Text(menu.title)
                                .font(.PretendardSemibold16)
                                .foregroundStyle(.seecontent)
                            Text(menu.englishTitle)
                                .font(.PretendardSemibold13)
                                .foregroundStyle(.service)
                        }
                    }
                }
            }.padding(.trailing, 140)
        }
    }
}


#Preview {
    OrderCircleImage()
}
