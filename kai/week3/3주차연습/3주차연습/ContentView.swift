//
//  ContentView.swift
//  3주차연습
//
//  Created by 김지우 on 3/31/25.
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

struct SimpleListView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleListView()
    }
}
