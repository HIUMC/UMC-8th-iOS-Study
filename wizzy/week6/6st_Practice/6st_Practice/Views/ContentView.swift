//
//  ContentView.swift
//  6st_Practice
//
//  Created by 이서현 on 5/12/25.
//

//책 조회하기 버튼
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
