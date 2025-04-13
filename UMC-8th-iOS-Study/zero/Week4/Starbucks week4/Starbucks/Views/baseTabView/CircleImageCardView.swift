//
//  CardView.swift
//  Starbucks
//
//  Created by 김영택 on 4/6/25.
//

import SwiftUI

struct CircleImageCardView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State private var router = NavigationRouter()
    
    var body: some View {
        
        
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(viewModel.coffeemenus, id: \.self) {menu in
                    VStack{
                        Image(menu.cimageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 130)
                            .clipped()
                        Spacer().frame(height: 10)
                        
                        Text(menu.cmenuName)
                            .font(.PretendardSemibold14)
                    }
                }
            }.padding(.leading, 20)
        }
    }
}

        
            
#Preview {
    CircleImageCardView()
}
