//
//  WhatView.swift
//  Starbucks
//
//  Created by 김영택 on 4/7/25.
//

import SwiftUI

struct WhatView: View {
    
    @StateObject var whats = WhatViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("What's New")
                .font(.PretendardRegular24)
            Spacer().frame(height: 10)
            
            ScrollView(.horizontal) {
                HStack(spacing:16) {
                    ForEach(whats.whatCard, id: \.self) { what in
                        VStack(alignment: .leading) {
                            Image(what.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 242, height: 160)
                                .cornerRadius(5)
                                .clipped()
                            Spacer().frame(height:16)
                                
                            Text(what.title)
                                .font(.PretendardSemibold18)
                                .frame(width: 242, alignment: .leading)
                                .lineLimit(nil)
                            Spacer().frame(height:9)
                            
                            Text(what.add)
                                .font(.PretendardRegular13)
                                .foregroundStyle(.gray)
                                .frame(width: 242, alignment: .leading)
                                .lineLimit(nil)
                            
                        }
                    }
                }
            }
        }.padding(.leading,20)
    }
}
#Preview {
    WhatView()
}
