//
//  LazyVGride.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct LazyVGridView: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
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
    LazyVGridView()
}
