//

//
//
//  listButtonView.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/3/25.
//

//재사용 가능한 양식
//이미지 , spacing : 6 , 텍스트


import SwiftUI

struct listItem: View {
    let icon: Image
    let content: String
    
    init(icon: Image, content: String) {
        self.icon = icon
        self.content = content
    }
    
    var body: some View {
        Button(action: {
            print(content)
        }, label: {
            HStack(spacing: 6) {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 32, maxHeight: 32)
                Text(content)
                    .font(.PretendardSemiBold16)
                
                Spacer()
            }
            .foregroundStyle(.black)
        })
        .frame(width: 180, height: 32)
    }
}

#Preview {
    listItem(icon: Image("coupon"), content: "쿠폰 등록")
}
