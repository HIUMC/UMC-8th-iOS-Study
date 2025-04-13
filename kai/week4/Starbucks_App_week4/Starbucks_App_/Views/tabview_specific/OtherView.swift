//
//  OtherView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import SwiftUI
import Observation

struct OtherView: View {
    @AppStorage("newID") var newID: String = "(작성한 닉네임)"
    @Binding var path: NavigationPath

        
    var body: some View {
        VStack{
            HStack{
                Text("Other")
                    .font(.PretendardExtraBold24)
                    .foregroundStyle(Color.logoblack)
                
                Spacer()
                    .frame(width: 250)
                
                Button(action: {
                                    print("로그아웃")
                                }) {
                                    Image(.logout)
                                }
            }//상단HStack_end
            
            
            Spacer()
                .frame(height:48)
            
            
            Text("\(newID)님\n   환영합니다!🙌")
                .font(.PretendardSemiBold24)
                .foregroundStyle(Color.logoblack)
            
            HStack{
                
                Button(action: {
                    print("별 히스토리 버튼 클릭됨")
                }){
                    Image(.starhistory)
                    Spacer()
                        .frame(width: 3)
                }
                
                Button(action:{
                    print("전자영수증 버튼 클릭됨")
                }){
                    Image(.recipt)
                    Spacer()
                        .frame(width: 3)
                }
                
                Button(action:{
                    print("나만의 메뉴 버튼 클릭됨")
                }){
                    Image(.mymenu)
                }
                
                
            }//버튼HStackEnd
            Spacer()
                .frame(height:30)
        
            HStack{
                
                Text("Pay")
                    .font(.PretendardMedium18)
                    .foregroundStyle(Color.logoblack)
                
                Spacer()
            }//PayHStack_end
            
                Spacer()
                    .frame(height:16)
            
            HStack{
             
                FeatureItemView(imageName: "cardregister", text: "스타벅스 카드 등록") {
                                                            print(" 스타벅스 카드 등록 버튼 클릭됨")
                                                        }
                Spacer()
                
                FeatureItemView(imageName: "exchange_register", text: "카드 교환권 등록") {
                                                            print("카드 교환권 등록 버튼 클릭됨")
                                                        }
                
            }//HStack-1_end
            
            Spacer()
                .frame(height:3)
            
            HStack{
                
                FeatureItemView(imageName: "coupon_register", text: "쿠폰 등록"){
                    print("쿠폰 등록 버튼 클릭됨")
                }
                    
                    
                Spacer()
                    .frame(width:35)
                
                FeatureItemView(imageName: "coupon_history", text: "쿠폰 히스토리"){
                    print("쿠폰 히스토리 버튼 클릭됨")
                }
                Spacer()
                    .frame(width:15)
                
            }//HStack-2_end
            
            Spacer()
                .frame(height:16)
            
            Divider()
            
            Spacer()
                .frame(height:30)
            
            HStack{
                Text("고객지원")
                    .font(.PretendardMedium18)
                    .foregroundStyle(Color.logoblack)
                Spacer()
            }//하단HStack_end
            
            Spacer()
                .frame(height:32)
            
            HStack{
                FeatureItemView(imageName: "storecare", text: "스토어 케어") {
                                                           print(" 스토어 케어 버튼 클릭됨")
                                                       }
                
            
            Spacer()
            
                FeatureItemView(imageName: "customer", text: "고객의 소리") {
                                                            print(" 고객의 소리 버튼 클릭됨")
                                                        }
            }//HStack-3_end
            
            Spacer()
                .frame(height:3)
            
            HStack{
                FeatureItemView(imageName: "location", text: "매장 정보") {
                                                            print("매장 정보 버튼 클릭됨")
                                                        }
                
            
            Spacer()
            
                FeatureItemView(imageName: "turnin", text: "반납기 정보") {
                                                            print("반납기 정보 버튼 클릭됨")
                                                        }
                
            }//HStack-4_end
            
            
            Spacer()
                .frame(height:3)
            
            HStack{
                FeatureItemView(imageName: "review", text: "마이 스타벅스 리뷰") {
                                                            print("마이 스타벅스 리뷰 버튼 클릭됨")
                                                        }
                Spacer()
                
            }//HStack-5_end
            
            


        }//전체 VStack end
        .padding(.horizontal,20)
  

        
    }
}

struct menuView: View{
    
    let imageName: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing:4) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                
                
                Text(title)
                    .font(.PretendardMedium16)
                    .foregroundColor(.logoblack)
            }
            .frame(width: 102, height: 108)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
          
        }
    }
}

struct FeatureItemView: View {
    let imageName: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack{
                Image(imageName)
                    
                
                Spacer().frame(width: 10)
                
                Text(text)
                    .font(.PretendardSemiBold16)
                    .foregroundStyle(Color.logoblack)
            }
            .padding(.vertical, 16)
            .frame(width: 157, alignment: .leading)
        }
    }
}

#Preview {
    OtherView(path: .constant(NavigationPath()))
}
