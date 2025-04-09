//
//  PayView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/2/25.
//

import SwiftUI

struct PayAreaView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        Button(action: {
            print("\(title)")
        }) {
            HStack {
                Image(imageName)
                    .padding(.trailing, 4)
                Text(title)
                    .lineLimit(1)
                    .fixedSize() //내용이 줄바꿈 없이 한 줄로 유지되도록 강제
                    .font(.PretendardSemiBold16)
                    .foregroundStyle(Color.black02)
                
            }
            .frame(width: 157, alignment: .leading)
            
            
        }
    }
}



