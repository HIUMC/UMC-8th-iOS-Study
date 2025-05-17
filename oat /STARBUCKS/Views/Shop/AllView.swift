//
//  AllView.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/4/25.
//

import SwiftUI

struct AllView: View {
    @StateObject var NewModel = AllViewModel()
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack{
                ForEach(NewModel.allname) {
                    card in AllCard(card: card)
                }
            }
        }
        .padding(.horizontal)
        .scrollIndicators(.hidden) 
    }
}

#Preview {
    AllView()
}
