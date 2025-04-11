//
//  AdvertiseView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/26/25.
// 배경사진 화면 꽉채우는건가요 .. ㅠㅠ

import SwiftUI

struct AdvertiseView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            Image(.advertise)
                .resizable()

                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 720)
                //.padding(.bottom,106)
//            Spacer().frame(height:60)
            
            Group{middleButton
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                //.padding(.bottom,72)
                
                EndButton()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                Spacer().frame(height:32)
            }
//            }.padding(.top)
            
        }
        .ignoresSafeArea()
    }
    private var middleButton: some View {
        Button(action:{
            print("자세히 보기 버튼 눌림")})
        {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.green01)
                .frame(height: 50)
                .overlay(
                    Text("자세히 보기")
                        .font(.mainTextMedium16)
                        .foregroundStyle(Color.white)
                )
        }
//        .padding(.horizontal, 20)
    }
        
}
struct EndButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack() {
            Spacer()
            Button("X 닫기") {
                dismiss()
            }
            .foregroundStyle(Color(red: 0.42, green: 0.42, blue: 0.42))
            .font(.mainTextLight14)
            .padding(.horizontal)
        }
        .padding(.top)
        .padding(.leading,30)
    }
}

#Preview {
    AdvertiseView()
}
