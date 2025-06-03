//
//  Coffee5View.swift
//  Starbucks
//
//  Created by 김영택 on 4/7/25.
//

import SwiftUI

struct Coffee5View: View {
    @State private var isHot = true
    var body: some View {
        VStack(alignment: .leading){
            Image(.rconpanna)
            Spacer().frame(height: 20)
            HStack{
                Text("에스프레소 콘 파나")
                    .font(.PretendardSemibold24)
                Image(.new)
            }
            .padding(.leading, 25)
            Text("Espresso Con Panna")
                .font(.PretendardSemibold14)
                .foregroundStyle(.gray)
                .padding(.leading, 25)

            Spacer().frame(height: 35)
            
            Text("신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료")
                .font(.PretendardRegular12)
                .padding(.leading, 25)
                .frame(width: 420,height:40)

            Spacer().frame(height: 20)
            Text("4,100원")
                .font(.PretendardRegular24)
                .padding(.leading, 25)

            Spacer().frame(height: 35)
            
            Text("HOT ONLY")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.red)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 150)
                        .fixedSize(horizontal: true, vertical: false)
                        .overlay(
                            Capsule()
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .padding(.leading, 29)
            Spacer().frame(height: 233)
            
            Button(action: {
                print("주문하기")
            }, label: {
                Text("주문하기")
                    .foregroundStyle(.tologin)
                    .frame(width: 383, height: 43)
                    .background(Color.login)
                    .cornerRadius(999)
            }).padding(.bottom, 80)
                .padding(.leading, 28)
        }
    }
}



#Preview {
    Coffee5View()
}
