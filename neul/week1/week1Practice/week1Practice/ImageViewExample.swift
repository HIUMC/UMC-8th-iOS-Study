//
//  ImageViewExample.swift
//  week1Practice
//
//  Created by tokkislove on 3/20/25.
//

import SwiftUI

struct ImageViewExample: View {
    var body: some View {
        ZStack {
            Color.pink.ignoresSafeArea(.all)
            Image("puzzle")
                .resizable( resizingMode: .tile) // 현재 뷰에 맞게 크기를 맞춤
                .frame(width: 300, height: 300) // 현재 뷰의 크기를 결정
                //.aspectRatio(contentMode: .fit) // 잘리지 않고 비율 유지됨
                //.aspectRatio(contentMode: .fill) // 잘리지만 화면에 꽉 차게 비율 유지됨
                // 아무것도 안쓰면 비율 유지 안되고 화면에 꽉참 (프레임을 이상하게 일그러뜨리면 뭘 하든 비율 깨짐)
                /*.background() {
                 Circle()
                        .fill(Color.green)
                        .frame(width: 250, height: 250)
                        .border(Color.black) // border가 원을 따라 생기는 게 아니라 원이 들어있는 네모 칸을 따라 생김
                 }
                 .border(Color.red) // 이것도 마찬가지로 이미지가 들어있는 네모 칸을 따라 border가 생김
                 .clipShape(RoundedRectangle(cornerSize: CGSize(width: 500, height: 500))) // border포함 이미지 그냥 잘라버리기
                 .foregroundStyle(Color.red)*/
        }
            
        
        
    }
}

#Preview {
    ImageViewExample()
}
