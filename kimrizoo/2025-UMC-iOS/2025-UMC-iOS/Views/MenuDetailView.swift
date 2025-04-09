//
//  MenuDetailView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/3/25.
//

import SwiftUI

struct MenuDetailView: View {
    let menu: MenuDetailModel?
    
    var body: some View {
        ZStack(alignment: .top) { // 배경을 맨 뒤로 배치
            Color.white.ignoresSafeArea()

            if let menu = menu {
                VStack{
                    VStack {
                        Image(menu.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 440, height: 355)
                            .ignoresSafeArea(edges: .top) // 이미지만 Safe Area 무시
                        
                        VStack(alignment: .leading) {
                            Text(menu.name)
                                .font(.customPretend(.medium, size: 24))
                            
                            Spacer().frame(height: 4)
                            
                            Text(menu.englishName)
                                .font(.customPretend(.regular, size: 14))
                                .foregroundColor(.gray)
                            
                            Spacer().frame(height: 40)
                            
                            Text(menu.description)
                            
                            Spacer().frame(height: 20)
                            
                            HStack {
                                Text("\(menu.price)원")
                                    .font(.customPretend(.regular, size: 24))
                            }
                            
                            
                        }
                        .padding(.horizontal, 10)
                        .offset(y: -40)
                    }
                    
                    Spacer()
                    
                    ZStack{
                        Button(action: {
                            
                        }) {
                            HStack {
                                Spacer()
                                Text("생성하기")
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            .frame(height: 46)
                            .background(Color.mainGreen)
                            .cornerRadius(20)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 15)
                        }
                    }
                }

            } else {
                Text("메뉴 정보를 불러올 수 없습니다.")
            }
        }
    }
}


#Preview {
    let sampleMenu = MenuDetailModel(
        name: "아이스 카라멜 마끼아또",
        englishName: "Iced Caramel Macchiato",
        description: "향긋한 바닐라 시럽과 시원한 우유에 얼음을 넣고 점을 찍듯이 에스프레소를 부은 후 별점 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료",
        price: 6100,
        imageName: "caramerlCold",
        availableTemperatures: [.iced]
    )
    
    return MenuDetailView(menu: sampleMenu)
}

