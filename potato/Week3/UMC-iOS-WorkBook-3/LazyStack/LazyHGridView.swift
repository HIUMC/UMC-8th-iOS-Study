//
//  LazyHGridView.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct LazyHGridView: View {
    let rows = Array(repeating: GridItem(.fixed(100)), count: 2)
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 10) {
                ForEach(1...15, id: \.self) { index in
                    Text("Item \(index)")
                        .frame(width: 80)
                        .frame(maxHeight: .infinity)
                        .background(Color.green.opacity(0.7))
                }
            }
        }
    }
}

#Preview {
    LazyHGridView()
}
