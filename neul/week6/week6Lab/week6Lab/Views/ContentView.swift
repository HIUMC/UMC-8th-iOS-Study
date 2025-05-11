//
//  ContentView.swift
//  week6Lab
//
//  Created by tokkislove on 5/10/25.
//

import SwiftUI

struct ContentView: View {
    @State var showCameraView: Bool = false
    var body: some View {
        Button(action: {
            showCameraView.toggle()
        }, label: {
            Text("책 조회하기")
                .font(.title)
                .foregroundStyle(Color.black)
        })
        .fullScreenCover(isPresented: $showCameraView, content: {
            ISBNScannerView()
        })
    }
}

#Preview {
    ContentView()
}
