//
//  OtherView.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/3/25.
//
//  OtherView.swift

//  Created by 고석현 on 4/1/25.
//

//구조
// Other 텍스트와 로그아웃 바 >> top 바
// 닉네임과 환영 바 >> welcome 바
//기본 메뉴 바 >> mesnu 바
//pay 바
// 고객지원 바 >> userService 바
// 뷰를 Z 스택으로, 하위 뷰들을 V,H 의 조합으로!!
//



//top section 과 mainContentSection
//mainContentSection 내 하위 섹션 쪼개지 뭐
//

import SwiftUI

struct OtherView: View {
    @AppStorage("nickname") var nickname : String = "(작성한 닉네임)"
    
    
    private var ViewModel : OtherViewModel = .init()
    
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                topSection
                    .padding(.top,68)
                    .padding(.horizontal,23.5)
                Spacer()
                
                mainContentView
                
                Spacer()
                
                customerServiceView
                    
                
                    
                    
                
              
            }
        }
       
        
    }
    private var topSection: some View {
        HStack {
            Text("Other")
                .font(.PretendardBold24)
                .foregroundStyle(.black01)
            Spacer()
                
            Button(action: {
                print("로그아웃")
            }, label: {
                Image("logout")
                    .resizable()
                    .frame(width:35,height:35)
            })
            
            
        }
    }
    
    private var mainContentView: some View {
        VStack {
            
            WelcomeSection
            
            Spacer()
            
            paySection// paySection
            
            Spacer()
            // customerServiceSection
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 41)
        .background(Color.white)
        
    }
    
    
    
    
    private var WelcomeSection: some View {
           VStack {
               VStack(spacing: 5) {
                   HStack {
                       Text(nickname)
                           .foregroundStyle(.green01)
                           .font(.PretendardSemiBold24)
                       Text("님")
                           .foregroundStyle(.black02)
                           .font(.PretendardSemiBold24)
                   }
                   Text("환영합니다! 🙌🏻")
                       .foregroundStyle(.black02)
                       .font(.PretendardSemiBold24)
               }
               
               HStack(spacing: 10.5) {
                   ButtonView(icon: Image("star_history"), title: "별 히스토리")
                   ButtonView(icon: Image("receipt"), title: "전자영수증")
                   ButtonView(icon: Image("cup"), title: "나만의 메뉴")
               }
               .padding(.top, 24)
           }
       }
    
    private var paySection: some View {
         VStack(alignment: .leading) {
             Text("Pay")
                 .font(.PretendardSemiBold18)
                 .padding(.bottom, 8)
             
             HStack {
                 listItem(icon: Image("card"), content: "스타벅스 카드 등록")
                 
                 Spacer()
                 
                 listItem(icon: Image("card_change"), content: "카드 교환권 등록")
             }
             .padding(.vertical, 16)
             
             HStack {
                 listItem(icon: Image("coupon"), content: "쿠폰 등록")
                 
                 Spacer()
                 
                 listItem(icon: Image("coupon_history"), content: "쿠폰 히스토리")
             }
             .padding(.vertical, 16)
         }
         .overlay(alignment: .bottom) {
             Divider()
                 .background(Color.black.opacity(0.12))
         }
         .padding(.horizontal, 10)
     }
    
    
    private var customerServiceView: some View {
            VStack(alignment: .leading) {
                Text("고객지원")
                    .font(.PretendardSemiBold18)
                
                HStack {
                    listItem(icon: Image("store_care"), content: "스토어 케어")
                    
                    Spacer()
                    
                    listItem(icon:Image("customer"), content: "고객의 소리")
                }
                .padding(.vertical, 16)
                
                HStack {
                    listItem(icon: Image("location"), content: "매장 정보")
                    
                    Spacer()
                    
                    listItem(icon: Image("return_info"), content: "반납기 정보")
                }
                .padding(.vertical, 16)
                
                HStack {
                    listItem(icon: Image("review"), content: "마이 스타벅스 리뷰")
                    
                    Spacer()
                }
                .padding(.vertical, 16)
            }
            .padding(.horizontal, 10)
        }
}


struct OtherView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            OtherView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}


