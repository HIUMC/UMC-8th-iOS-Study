//
//  OtherView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/27/25.
//

import SwiftUI

struct OtherView: View {
    
    @StateObject private var viewModel = SignupViewModel()
    
    var body: some View {
        NavigationStack{
            HStack(spacing: 260){
                
                
                Text("Other")
                    .font(.mainTextBold24)
                
                NavigationLink(destination: LoginView()){
                    Image("logout")
                }
            }
            
        
        
        Spacer().frame(height: 41)
        
            VStack{
                
                Text(viewModel.storedname.isEmpty ? "(작성한 닉네임)" : viewModel.storedname)
                    .foregroundColor(.green01)
                    .font(.mainTextSemiBold24)
                
                + Text("님 \n     환영합니다!")
                    .font(.mainTextSemiBold24)
                
                Spacer().frame(height: 24)
                
                
                HStack{
                    
                    Button(action:{print("별 히스토리")}) {
                        Image("starhistory")
                    }
                    
                    Button(action:{print("전자영수증")}) {
                        Image("receipt")
                    }
                    
                    Button(action:{print("나만의 메뉴")}) {
                        Image("mymenu")
                    }
                    
                }.frame(width: 375, height: 108)
                //Pay stack 시작
                
                Spacer().frame(height: 41)
                
                VStack(alignment: .leading){
                    Text("Pay")
                        .font(.PretendardBold18)
                    
                    Spacer().frame(height: 8)
                    
                    
                    HStack{
                        
                        VStack(alignment: .leading){
                            
                            MenuBtn(image: .starbuckscardregister, text: "스타벅스 카드 등록", action: {print("스타벅스 카드 등록")})
                            
                            
                            MenuBtn(image: .couponregister, text: "쿠폰 등록", action: {print("쿠폰 등록")})
                            
                        }//VStack
                        Spacer()
                        
                        VStack(alignment: .leading){
                            
                            MenuBtn(image: .cardexchangevoucher, text: "카드 교환권 등록", action: {print("카드 교환권 등록")})
                            
                            
                            MenuBtn(image: .couponhistory, text: "쿠폰 히스토리", action: {print("쿠폰 히스토리")})
                            
                        }//VStack
                        
                    }//HStack
                    
                }/* Pay VStack 끝 */
                .padding(.horizontal, 19)
                
                Spacer().frame(height: 41)
                
                Divider()
                
                Spacer().frame(height: 41)
                
                VStack(alignment: .leading){
                    
                    Text("고객지원")
                        .font(.PretendardBold18)
                        .padding(.horizontal, 19)
                    
                    Spacer().frame(height: 8)
                    
                    HStack{
                        
                        VStack(alignment: .leading){
                            
                            MenuBtn(image: .storecare, text: "스토어 케어", action: {print("스토어 케어")})
                            
                            
                            MenuBtn(image: .storeinfo, text: "매장 정보", action: {print("매장 정보")})
                            
                            
                            MenuBtn(image: .mystarbucksreview, text: "마이 스타벅스 리뷰", action: {print("마이 스타벅스 리뷰")})
                            Spacer()
                        }//VStack
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            
                            MenuBtn(image: .customersound, text: "고객의 소리", action: {print("고객의 소리")})
                            
                            
                            MenuBtn(image: .returninfo, text: "반납기 정보", action: {print("반납기 정보")})
                            
                            Spacer()
                        }//VStack
                        
                    }//HStack
                    .padding(.horizontal, 19)
                }
            }
        } //VStack
    }//HStack
}// Pay VStack 끝

struct MenuBtn: View {
    
    let image: ImageResource
    let text: String
    let action: () -> Void
    
    init(image: ImageResource, text: String, action: @escaping () -> Void) {
        self.image = image
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button (action: action) {
            HStack(spacing: 8) {
                Image(image)
                Text(text)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(.black02)
                
            }
        }
    }
}

#Preview {
    OtherView()
}
