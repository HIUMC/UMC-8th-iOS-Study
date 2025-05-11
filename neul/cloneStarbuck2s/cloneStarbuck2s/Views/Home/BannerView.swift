//
//  BannerView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/3/25.
//
import SwiftUI

struct BannerView: View {
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Image(.home1)
                Spacer().frame(height: 33)
            }
            
            VStack(alignment: .leading) {
                Spacer()
                Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                    .font(.MainTextBold24)
                    .foregroundStyle(.black03)
                Spacer().frame(height: 34)
                progressBar
            }
        }
        .frame(maxWidth: .infinity, minHeight: 259)
    }
    
    private var progressBar: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text("11★ until next Reward")
                    .font(.MainTextSemiBold16)
                    .foregroundStyle(.brown02)
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // 배경 바
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "DBDBDB"))
                            .frame(height: 10)

                        // 채워진 부분
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.brown01)
                            .frame(width: geometry.size.width * (1 / 12), height: 10)
                            .animation(.easeInOut, value: 1)
                    }
                }
                .frame(width: 256, height: 8)
            }
            
            VStack(spacing: 5) {
                HStack(spacing: 4) {
                    Button {
                        print("내용 보기")
                    } label: {
                        Text("내용 보기")
                            .font(.MainTextRegular13)
                            .foregroundStyle(.gray06)
                    }
                    Image(.goButton)
                        .frame(width: 16, height: 16)
                    
                }
                
                HStack(spacing: 5) {
                    Text("1")
                        .font(.MainTextSemiBold38)
                        .foregroundStyle(.black03)
                    Text("/")
                        .font(.pretend(type: .light, size: 24))
                        .foregroundStyle(Color(hex: "C9C9C9"))
                    Text("12★")
                        .font(.MainTextSemiBold24)
                        .foregroundStyle(.brown02)
                }
            }
        }
    }

    
}
