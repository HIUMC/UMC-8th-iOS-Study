//
//  LazyVGridExample.swift
//  week3Practice
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct LazyVGridExample: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    // count가 3이라서 3개의 열인 거세요.
       
       var body: some View {
           ScrollView {
               LazyVGrid(columns: columns, spacing: 10) {
                   ForEach(1...20, id: \.self) { index in
                       Text("Item \(index)")
                           .frame(height: 80)
                           .frame(maxWidth: .infinity)
                           .background(Color.blue.opacity(0.7))
                   }
               }
           }
       }
}

#Preview {
    LazyVGridExample()
}
