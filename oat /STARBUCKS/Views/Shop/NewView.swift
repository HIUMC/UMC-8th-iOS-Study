//
//  NewView.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/4/25.
//

import SwiftUI

struct NewView: View {
    @StateObject var NewModel = NewViewModel()
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        LazyVGrid(columns: columns,alignment: .leading,spacing: 30) {
            ForEach(NewModel.Newname) { item in
                VStack(alignment: .leading) {
                    Image(item.imageName)
                        .resizable()
                    
                    Spacer().frame(height:12)
                    
                    Text(item.title)
                        .font(.mainTextSemibold14)
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom,80)
    }
}
                

#Preview {
    NewView()
}
