//
//  NewView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//

import SwiftUI

struct NewView: View {
    @Bindable var viewModel: NewViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(viewModel.items) { item in
                    VStack{
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 242, height: 160)
                        
                        Spacer()
                            .frame(height:10)
                        
                        Text(item.title)
                            .font(.PretendardRegular18)
                        
                        Spacer()
                            .frame(height:10)
                        
                        Text(item.description)
                            .font(.PretendardRegular13)
                            .foregroundStyle(Color.gray)
                            .multilineTextAlignment(.leading)
                                .lineLimit(2)
                    }//Vstack
                    
                }
            }
        }
    }
    
}
    #Preview {
        NewView(viewModel: NewViewModel())
    }
