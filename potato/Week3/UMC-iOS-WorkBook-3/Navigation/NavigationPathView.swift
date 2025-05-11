//
//  NavigationPathView.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct NavigationPathView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Go to Detail") {
                    path.append("Detail")
                }
            }
            .navigationDestination(for: String.self) { value in
                PathDetailView()
            }
            .navigationTitle("Home")
        }
    }
}

struct PathDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Detail Page")
            Button("Go Back") {
                dismiss() // 현재 화면을 닫고 이전 화면으로 돌아감
            }
        }
        .navigationTitle("Detail")
    }
}

#Preview {
    NavigationPathView()
}
