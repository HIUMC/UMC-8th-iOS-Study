//
//  CombineLazyView.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct CombineLazyStack: View {
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20, content: {
                ForEach(1...10, id: \.self) { rowIndex in
                    VStack(alignment: .leading, content: {
                        Text("섹션 \(rowIndex)")
                            .font(.headline)
                        
                        ScrollView(.horizontal, content: {
                            LazyHStack(spacing: 10, content: {
                                ForEach(1...10, id: \.self) { columnIndex in
                                    Text("아이템 :\(columnIndex)")
                                        .frame(width: 80, height: 80)
                                        .background(Color.blue.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            })
                            .padding(.bottom, 10)
                        })
                    })
                }
            })
        }
    }
}

#Preview {
    CombineLazyStack()
}


#Preview {
    CombineLazyStack()
}
