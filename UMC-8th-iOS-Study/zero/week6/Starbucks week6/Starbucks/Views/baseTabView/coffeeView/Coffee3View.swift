//
//  Coffee3View.swift
//  Starbucks
//
//  Created by 김영택 on 4/7/25.
//

import SwiftUI

struct Coffee3View: View {
    @State private var isHot = true
    var body: some View {
        VStack(alignment: .leading){
            Image(.ramericano)
            Spacer().frame(height: 20)
            HStack{
                Text("아이스 카페 아메리카노")
                    .font(.PretendardSemibold24)
                Image(.new)
            }
            .padding(.leading, 25)
            Text("Iced Caffe Americano")
                .font(.PretendardSemibold14)
                .foregroundStyle(.gray)
                .padding(.leading, 25)

            Spacer().frame(height: 35)
            
            Text("진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피")
                .font(.PretendardRegular12)
                .padding(.leading, 25)
                .frame(width: 420,height:40)

            Spacer().frame(height: 20)
            Text("4,700원")
                .font(.PretendardRegular24)
                .padding(.leading, 25)

            Spacer().frame(height: 35)
            
            HStack(spacing: 0) {
                Text("HOT")
                    .frame(width: 190, height: 36)
                    .background(isHot ? Color.white : Color.clear)
                    .foregroundColor(isHot ? .red : .gray)
                    .onTapGesture {
                        isHot = true
                    }
                
                Text("ICED")
                    .frame(width: 190, height: 36)
                    .background(!isHot ? Color.white : Color.clear)
                    .foregroundColor(!isHot ? .blue : .gray)
                    .onTapGesture {
                        isHot = false
                    }
            }.padding(.leading,40)

            .background(Color.gray.opacity(0.15))
            .clipShape(Capsule())
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
    Coffee3View()
}
