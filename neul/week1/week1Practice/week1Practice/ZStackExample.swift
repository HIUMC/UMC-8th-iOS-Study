//
//  ZStackExample.swift
//  week1Practice
//
//  Created by tokkislove on 3/22/25.
//

import SwiftUI

struct ZStackExample: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.pink)
                .frame(width: 200, height: 200)
            Text("핑크 짱")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ZStackExample()
}
