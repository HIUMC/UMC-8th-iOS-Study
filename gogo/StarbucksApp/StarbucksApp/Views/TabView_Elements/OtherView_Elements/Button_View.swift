//
//  ButtonView.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/7/25.
//

//


import SwiftUI

//


import SwiftUI

struct ButtonView: View {
    let icon: Image
    let title: String
    
    init(icon: Image, title: String) {
        self.icon = icon
        self.title = title
    }
    
    var body: some View {
        Button(action: {
            print(title)
        }, label: {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(width: 102, height: 108)
                .shadow(radius: 2, x: 0, y: 0)
                .overlay(content: {
                    VStack(spacing: 4) {
                        icon
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundStyle(.green01)
                        
                        Text(title)
                            .font(.PretendardSemiBold16)
                            .foregroundStyle(.black03)
                    }
                })
        })
    }
}

#Preview {
    ButtonView(icon: Image(systemName: "star"), title: "별 히스토리")
}
