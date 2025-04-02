//
//  CustomNav.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import SwiftUI

struct CustomNav: View {
    let title: String
    let onBack: (() -> Void)
        
    init(title: String, onBack: @escaping (() -> Void)) {
        self.title = title
        self.onBack = onBack
    }
    
    var body: some View {
        HStack {
            Button(action : {
                onBack()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
            
            Spacer()
            
            Text(title)
                .font(.mainTextMedium16)
            
            Spacer()
            
            Rectangle()
                .fill(.clear)
                .frame(width: 24, height: 24)
        }
        .padding()
    }
}
