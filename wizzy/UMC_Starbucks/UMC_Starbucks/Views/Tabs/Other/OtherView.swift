//
//  OtherView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/31/25.
//

import SwiftUI
struct OtherView: View {
    @AppStorage("isLoginOK") private var isLoginOK: Bool = true
    @AppStorage("nickname") private var storedNickname: String = ""
    @AppStorage("email") var storedEmailAccount: String = ""
    @AppStorage("pwd") var storedPassword: String = ""
    
    var body: some View {
        NavigationStack {
            VStack { //v1
                VStack { // v2 [Other ~ 나만의 메뉴]
                    HStack {
                        Text("Other")
                            .font(.PretendardBold24)
                            .foregroundStyle(Color.black)
                        Spacer()
                        NavigationLink(destination: LoginView()) {
                            Image("logout")
                                .resizable()
                                .frame(width: 35, height: 35)
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
                            
                            Text("환영합니다!")
                        }
                        .font(.PretendardSemiBold24)
                        
                    } //v3 [님 환영합니다]
                    .padding(.bottom, 24)
                    
                    HStack(spacing: 12) {
                        OtherButtonView(title: "별 히스토리", imageName: "Star", destination: AnyView(ReceiptView()))
                        
                        OtherButtonView(title: "전자 영수증", imageName: "receipt", destination: AnyView(ReceiptView()))
                        
                        OtherButtonView(title: "나만의 메뉴", imageName: "myMenu", destination: AnyView(ReceiptView()))
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
                            PayAreaView(imageName: "cardicon", title: "스타벅스 카드 등록")
                            
                            Spacer()
                            PayAreaView(imageName: "cardChangeicon", title: "카드 교환권 등록")
                            
                        } //h
                        .padding(.vertical, 16)
                        
                        HStack {
                            PayAreaView(imageName: "couponicon", title: "쿠폰 등록")
                            
                            Spacer()
                            PayAreaView(imageName: "couponHistoryicon", title: "쿠폰 히스토리")
                            
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
                            PayAreaView(imageName: "storeCareicon", title: "스토어 케어")
                            
                            Spacer()
                            PayAreaView(imageName: "soundicon", title: "고객의 소리")
                            
                        } //h
                        .padding(.vertical, 16)
                        
                        HStack {
                            NavigationLink(destination: FindStoreView()) {
                                HStack {
                                    Image("locationicon")
                                        .padding(.trailing, 4)
                                    Text("매장 정보")
                                        .lineLimit(1)
                                        .fixedSize() //내용이 줄바꿈 없이 한 줄로 유지되도록 강제
                                        .font(.PretendardSemiBold16)
                                        .foregroundStyle(Color.black02)
                                }
                                .frame(width: 157, alignment: .leading)
                            }
                            
                            Spacer()
                            PayAreaView(imageName: "returnicon", title: "반납기 정보")
                            
                        } //h
                        .padding(.vertical, 16)
                        
                        HStack {
                            PayAreaView(imageName: "reviewicon", title: "마이 스타벅스 리뷰")
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
    
    private var logoutButton: some View {
        Button {
            isLoginOK = false
        } label: {
            Image("logout")
                .resizable()
                .frame(width: 35, height: 35)
        }
        
        
    }
    
}





        
#Preview {
    OtherView()
}
