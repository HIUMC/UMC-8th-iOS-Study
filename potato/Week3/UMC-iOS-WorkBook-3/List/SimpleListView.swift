//
//  SimpleListView.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct SimpleListView: View {
    var body: some View {
        List {
            Text("🍎 Apple")
            Text("🍌 Banana")
            Text("🍒 Cherry")
        }
    }
}

#Preview {
    SimpleListView()
}
