//
//  Coffee1View.swift
//  Starbucks
//
//  Created by 김영택 on 4/7/25.
//

import SwiftUI

struct CoffeeDetailView: View {
    @State private var isHot = true
    
    var menu: CoffeeDetail

    var body: some View {
        VStack {
            Image(menu.coffeeimage)
                .resizable()
                .scaledToFit()

            Text(menu.coffeename)
                .font(.title)
                .padding()
                .font(.PretendardSemibold24)
            Image(.new)
            
            Text(menu.comments)
                .font(.PretendardRegular12)
                .padding(.leading, 25)
                .frame(width: 420,height:40)
            
            Text(menu.price)
                .font(.PretendardRegular24)
                .padding(.leading, 25)
        }
    }
}

#Preview {
    CoffeeDetailView(menu:CoffeeDetail(coffeeimage: "icemachi",coffeename: "아이스 카라멜 마끼아또",  comments: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: "3,500원" ))
}

















/*struct CoffeeDetailView: View {
    @State private var isHot = true
    var body: some View {
        VStack(alignment: .leading){
            Image(.icemachi)
            Spacer().frame(height: 20)
            HStack{
                Text("아이스 카라멜 마끼아또")
                    .font(.PretendardSemibold24)
                Image(.new)
            }
            .padding(.leading, 25)
            Text("Iced Caramel Macchiato")
                .font(.PretendardSemibold14)
                .foregroundStyle(.gray)
                .padding(.leading, 25)

            Spacer().frame(height: 35)
            
            Text("향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료")
                .font(.PretendardRegular12)
                .padding(.leading, 25)
                .frame(width: 420,height:40)

            Spacer().frame(height: 20)
            Text("6,100원")
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

*/

