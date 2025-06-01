//
//  CircleImageCard.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//


import SwiftUI
 
struct CircleImageCard: View {
    let coffee: CoffeeCardModel
    @StateObject private var viewModel = CoffeeViewModel()
    @State private var isActive = false  // 네비게이션 활성화 상태 관리

    var body: some View {
        VStack {
            Image(coffee.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 130)
                .clipShape(Circle())
            
            Spacer().frame(height: 10)
            
            Text(coffee.title)
                .font(.PretendardMedium16)
                .foregroundStyle(.black)
        }
        .frame(width: 130, height: 160)
        .onTapGesture {
            viewModel.selectMenu(name: coffee.title)
            isActive = true
        }
        
    
    }
}
