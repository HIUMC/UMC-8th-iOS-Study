//
//  BreadCircleImageView.swift
//  Starbucks
//
//  Created by 김영택 on 4/7/25.
//

import SwiftUI

struct BreadImageView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("하루가 달콤해지는 디저트")
                .font(.PretendardBold24)
            Spacer().frame(height: 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(viewModel.breadmenus, id: \.self) {menu in
                        VStack{
                            Image(menu.bimageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .clipped()
                            Spacer().frame(height: 10)
                            
                            Text(menu.bmenuName)
                                .font(.PretendardSemibold14)
                        }
                    }
                }
            }
        }.padding(.leading, 20)
    }
}

#Preview {
    BreadImageView()
}
