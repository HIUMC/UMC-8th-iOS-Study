//
//  BannerView.swift
//  Starbucks
//
//  Created by 박정환 on 3/31/25.
//

import SwiftUI

struct BannerView: View {
    @Environment(\.dismiss) var dismiss  // @Environment의 dismiss 사용
        
    var body: some View {
            VStack {
                Image("ad")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .top)
                    .frame(maxWidth: .infinity, maxHeight: 720)
                
                moreButton
                closeButton
            }
            .padding(.bottom, 36)
        }
        
        private var moreButton: some View {
            Button(action: {
                print("자세히 보기")
            }, label: {
                Text("자세히 보기")
                    .font(.mainTextMedium16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 402, maxHeight: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("green01"))
                    )
            })
            .padding(.top, 106)
            .padding(.horizontal, 18)
        }
        
        private var closeButton: some View {
            HStack {
                Spacer()
                
                Button(action: {
                    print("닫기 버튼 클릭")
                    dismiss()
                }, label: {
                    Text("X 닫기")
                        .font(.mainTextLight14)
                        .foregroundColor(Color("gray05"))
                })
            }
            .padding(.top, 19)
            .padding(.trailing, 37)
        }
    }

#Preview {
    BannerView()
}
