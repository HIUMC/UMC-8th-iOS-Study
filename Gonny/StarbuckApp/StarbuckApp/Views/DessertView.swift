//
//  DessertView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//
//홈뷰에 있는 디저트(수평스크롤)

import SwiftUI

struct DessertView: View{
    @StateObject private var viewModel=DessertViewModel()
    
    var body: some View{
        
        
        VStack(alignment: .leading){
            Text("하루가 달콤해지는 디저트")
                .font(.mainTextSemiBold24)
                .foregroundColor(Color("black03"))
                //.padding(.bottom, 16)
                .padding(.leading, 20)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing:50){
                    ForEach(viewModel.dessertItems){item in
                        CircleImageCard(item: item)}
                }
                .padding(.leading, 30)
            }
            
            .padding(.top,20)
        }
    }
}
#Preview {
    DessertView()
}
