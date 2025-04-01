//
//  HomeView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/31/25.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
