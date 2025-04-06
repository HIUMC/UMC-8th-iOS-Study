//
//  BreadAsset.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/3/25.
//

import SwiftUI

struct BreadAssetView: View {
    let bread: BreadAssetModel
    


    var body: some View {
        VStack {
            Image(bread.image)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle()) // 동그랗게 만들기
            
            Text(bread.name)
                .font(.headline)
                .foregroundColor(.black)
        }
       
    }
}
struct BreadListView: View {
    @StateObject var viewModel = BreadAssetViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("하루가 달콤해지는 디저트")
                .font(.mainTextBold24)
            
            ScrollView(.horizontal, showsIndicators: false) { // 가로 스크롤 가능
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.breads) { bread in
                        BreadAssetView(bread: bread)
                    }
                }
                
            }
        }
    }
}

#Preview {
    BreadListView()
}
