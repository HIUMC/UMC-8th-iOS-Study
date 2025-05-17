//
//  CoffeeView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//

import SwiftUI

struct CoffeeView: View {
    @Environment(\.dismiss) private var dismiss  // 뒤로가기
    @StateObject var viewModel = CoffeeViewModel()

    let coffee: CoffeeModel?
    
    var body: some View {
        ZStack{
            Color.white
            HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(.back)
                            }
                            

                            Spacer()
                            
                            Button(action:{}) {
                                Image(.share)
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                        } //상단HStack_end
                        Spacer()

            if let coffee = coffee{
                VStack {
                    Image(coffee.imageName)
                        .resizable()
                        .scaledToFit()
                    VStack(alignment: .leading, spacing: 8) {
                        
                        // 한글 커피이름 + NEW
                        HStack(spacing: 6) {
                            Text(coffee.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("New")
                                .foregroundColor(.green)
                                .font(.footnote)
                                .padding(.top, 4)
                        }
                        
                        
                        // 영어 이름
                        Text(coffee.englishName)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        // 설명
                        Text(coffee.description)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                        
                        
                        // 가격
                        Text("\(coffee.price)원")
                            .font(.title)
                        
                        
                        Button(action:{
                            print("주문하기")
                        }){
                            Image(.orderbutton)
                                .resizable()
                                .scaledToFit( )
                            
                        }//Button_end
                    }//TextVStack_end
                }//VStack_end
            }//iflet_end
        }//ZStack_end
    }//View_end
}


#Preview {
    let sampleMenu = CoffeeModel(
        imageName: "caramelCold_square", name: "아이스 카라멜 마끼아또", englishName: "Iced Caramel Macchiato", description: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부\n은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price:6100 , availableTypes: [.iced, .hot]
    )
    
    return CoffeeView(coffee: sampleMenu)
}
