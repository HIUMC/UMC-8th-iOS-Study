//
//  ListNavView.swift
//  week3Practice
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct ListNavView: View {
    let items = ["Apple", "Banana", "Cherry", "Mango"]
    
    var body: some View {
        NavigationStack {
            List(items, id: \.self) { item in
                NavigationLink {
                    DetailView(item: item)
                } label: {
                    Text(item)
                }

            }
        }
    }
}

fileprivate struct DetailView: View {
    let item: String
    var body: some View {
        Text("Selected: \(item)")
            .font(.largeTitle)
            .navigationTitle(item)
    }
}

#Preview {
    ListNavView()
}
