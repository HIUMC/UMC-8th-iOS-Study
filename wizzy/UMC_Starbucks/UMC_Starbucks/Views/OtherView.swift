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
            VStack { // v2 [Other ~ 나만의 메뉴]
                HStack {
                    Text("Other")
                        .font(.PretendardBold24)
                        .foregroundStyle(Color.black)
                    Spacer()
                    Button(action: {
                        print("로그아웃") // 버튼 눌렀을 때 동작
                    }) {
                        Image("logout") // 사진을 버튼 UI로 사용
                    }
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
                    
                } //v3 [님 환영합니다]
                .padding(.bottom, 24)
                
                HStack(spacing: 12) {
                    OtherButtonView(title: "별 히스토리", imageName: "Star")
                    OtherButtonView(title: "전자영수증", imageName: "receipt")
                    OtherButtonView(title: "나만의 메뉴", imageName: "myMenu")
                } // h
            }//v2 [Other~나만의 메뉴]
            
            Spacer()
//----------------------------
            VStack { //v4 [Pay]
                Text("Pay")
                    .font(.PretendardSemiBold18)
                    .kerning(-0.3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack { //v5 [payView]
                    HStack {
                        PayView(imageName: "cardicon", title: "스타벅스 카드 등록")
                            
                        Spacer()
                        PayView(imageName: "cardChangeicon", title: "카드 교환권 등록")
                            
                    } //h
                    .padding(.vertical, 16)
                    
                    HStack {
                        PayView(imageName: "couponicon", title: "쿠폰 등록")
                            
                        Spacer()
                        PayView(imageName: "couponHistoryicon", title: "쿠폰 히스토리")
                            
                    } //h
                    .padding(.vertical, 16)
                    
                }// v5 [payView]
                HStack {
                    Rectangle()
                        .frame(width: 327, height: 1)
                        .foregroundStyle(Color.black00)
                        .opacity(0.12)
                    Spacer()
                }
                
            } //v4 [Pay]
            Spacer()
 //---------------------------
            
            VStack { //v6 [고객지원]
                Text("고객지원")
                    .font(.PretendardSemiBold18)
                    .kerning(-0.3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) { //v7 [고객지원View]
                    HStack {
                        PayView(imageName: "storeCareicon", title: "스토어 케어")
                            
                        Spacer()
                        PayView(imageName: "soundicon", title: "고객의 소리")
                            
                    } //h
                    .padding(.vertical, 16)
                    
                    HStack {
                        PayView(imageName: "locationicon", title: "매장 정보")
                            
                        Spacer()
                        PayView(imageName: "returnicon", title: "반납기 정보")
                            
                    } //h
                    .padding(.vertical, 16)
                    
                    HStack {
                        PayView(imageName: "reviewicon", title: "마이 스타벅스 리뷰")
                            .frame(width: 157, alignment: .leading)
                        Spacer()
                            .padding(.leading, 19)
                    }
                    .padding(.vertical, 16)
                            
                        
                        
                    
                }// v7 [고객지원View]
        //❔❔ 정렬 왜이래! 간격 왜이래1! ❔❔/
                
            } //v6 [고객지원]
            
            
            
            
            
            
            
            
 //----------------------------
        } //v1
        .padding(.horizontal, 19)

    }
}

struct OtherButtonView: View {
    let title: String
    let imageName: String

    var body: some View { // 🆘 init으로..
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
                        //.resizable() ❔❔같은 frame 크기로 해도 사진 크기가 다른지 모르겠음!
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


struct PayView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        Button(action: {
        }) {
            HStack {
                Image(imageName)
                    .padding(.trailing, 4)
                Text(title)
                    .lineLimit(1)
                    .fixedSize() //내용이 줄바꿈 없이 한 줄로 유지되도록 강제
                    .font(.PretendardSemiBold16)
                    .foregroundStyle(Color.black02)
                
            }
            .frame(width: 157, alignment: .leading)
            
            
        }
    }
}





        
#Preview {
    OtherView()
}
