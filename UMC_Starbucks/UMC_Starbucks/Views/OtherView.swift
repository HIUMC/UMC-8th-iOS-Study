//
//  OtherView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/31/25.
//

import SwiftUI

struct OtherView: View {
    
    @AppStorage("nickname") private var storedNickname: String = ""
    var body: some View {
        VStack { //v1
            VStack { // v2
                HStack {
                    Text("Other")
                        .font(.PretendardBold24)
                        .foregroundStyle(Color.black)
                    Spacer()
                    Image("logout")
                } //h
                .padding(.horizontal, 19)
                .padding(.bottom, 41)
                
                VStack(alignment: .center) { //v3
                    Group {
                        HStack {
                            Text(storedNickname.isEmpty ? "(작성한 닉네임)" : storedNickname)
                                .foregroundStyle(.loginButtonGreen)
                            
                            Text("님")
                            /*
                             Text(storedNickname == "" ? "(작성한 닉네임)" : \(storedNickname))
                             .padding(.top, 5)
                             */
                        } // h (닉네임 님)
                        .padding(.top, 5)
                        
                        Text("환영합니다! 🙌🏻")
                    }
                    .font(.PretendardSemiBold24)
                    
                    
                    
                    
                } //v3
                .padding(.bottom, 24)
                
                HStack(spacing: 12) {
                    OtherButtonView(title: "별 히스토리", imageName: "Star")
                    OtherButtonView(title: "전자영수증", imageName: "receipt")
                    OtherButtonView(title: "나만의 메뉴", imageName: "myMenu")
                }
            }//v2
            
        } //v1
        .padding(.horizontal, 19)

    }
}

struct OtherButtonView: View {
    let title: String
    let imageName: String

    var body: some View {
        Button(action: {
            print(title) // ✅ 버튼 누르면 해당 텍스트 출력
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(width: 102, height: 108)
                    .shadow(color: .black.opacity(0.1), radius: 3)

                VStack {
                    Image(imageName)
                        //.resizable() ❔같은 frame 크기로 해도 사진 크기가 다른지 모르겠음!
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.top, 19)
                        .padding(.bottom, 4)

                    Text(title)
                        .font(.PretendardSemiBold16)
                        .foregroundStyle(Color.black03)
                        .padding(.bottom, 19)
                }
            }
        }
    }
}
        
#Preview {
    OtherView()
}
