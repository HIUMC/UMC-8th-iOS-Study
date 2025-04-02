//
//  NavigationView.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct NavigationView: View {
    let items = ["Apple", "Banana", "Cherry", "Mango"]
    
    var body: some View {
        NavigationStack {
            List(items, id: \.self) { item in
                NavigationLink(destination: DefaultDetailView(item: item)) {
                    Text(item)
                }
            }
            .navigationTitle("Fruits")
        }
    }
}

struct DefaultDetailView: View {
    let item: String
    
    var body: some View {
        Text("Selected: \(item)")
            .font(.largeTitle)
            .navigationTitle(item)
    }
}

#Preview {
    NavigationView()
}
