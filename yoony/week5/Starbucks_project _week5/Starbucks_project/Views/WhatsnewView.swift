//
//  WhatsnewView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/3/25.
//

import SwiftUI

// 개별 이미지 뷰
struct WhatsnewItemView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 240, height: 249)
            .clipShape(RoundedRectangle(cornerRadius: 10)) // 둥근 모서리 추가
    }
}

// 전체 이미지 리스트 뷰
struct WhatsnewListView: View {
    let viewModel = WhatsnewViewModel() // 뷰 모델 선언
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What's New")
                .font(.mainTextBold24)
                
            
            ScrollView(.horizontal, showsIndicators: false) {  // 가로 스크롤
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.images, id: \.self) { imageName in
                        WhatsnewItemView(imageName: imageName)
                    }
                }.frame(maxWidth: .infinity)
            }
        }.padding(.leading, 20)
    }
}

#Preview {
    WhatsnewListView()
}

