//
//  MyOwnMenu.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/8/25.
//

import SwiftUI

struct MyOwnMenuView: View {
    
    var body: some View {
        VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("나만의 메뉴보는 뷰!")
            .padding()
        }
    }
    
    
}


#Preview {
    MyOwnMenuView()
}
