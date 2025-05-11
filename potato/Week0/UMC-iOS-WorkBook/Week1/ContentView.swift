//
//  ContentView.swift
//  UMC-iOS-WorkBook
//
//  Created by 곽은채 on 3/16/25.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Image(systemName: "eraser.fill")
            .resizable(capInsets: EdgeInsets(top: 0.0, leading: -1.0, bottom: 0.0, trailing: 0.0))
            .frame(width: 150, height: 100)
            .aspectRatio(contentMode: .fill)
            .background() {
                Circle()
                    .fill(Color.green)
                    .frame(width: 250, height: 250)
                    .border(Color.black)
            }
            .border(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 100))
            .foregroundStyle(Color.red)
    }
}

#Preview {
    SwiftUIView()
}
