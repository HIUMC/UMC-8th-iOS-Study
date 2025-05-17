//
//  OtherButtonView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/2/25.
//

import SwiftUI

struct OtherButtonView: View { // 별 히스토리 ~ 나만의 메뉴
    let title: String
    let imageName: String
    let destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            //Button(action: {
              //  print(title) // ✅ 버튼 누르면 해당 텍스트 출력
           // }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: 102, height: 108)
                        .shadow(color: .black.opacity(0.1), radius: 3)
                    
                    VStack {
                        Image(imageName)
                        //.resizable() ❔❔같은 frame 크기로 해도 사진 크기가 다른지 모르겠음!
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding(.top, 19)
                            .padding(.bottom, 4)
                        
                        Text(title)
                            .font(.PretendardSemiBold16)
                            .foregroundStyle(Color.black03)
                            .padding(.bottom, 19)
                  //  }
                }
            }
        }
    }
}

