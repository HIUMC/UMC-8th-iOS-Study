//
//  OtherView.swift
//  Starbucks
//
//  Created by 김영택 on 3/29/25.
//
import Foundation
import SwiftUI

struct OtherView: View {
    
    @AppStorage("newID") private var nickname: String = ""
    
    var body: some View {
        
        VStack {
            TopView
            ContentView
        }
    }
    
    private var TopView: some View {
        HStack {
            Text("Other")
                .font(.PretendardExtrabold24)
                .foregroundStyle(.black)
            
            Spacer().frame(width: 255)
            
            Button(action: {
                print("로그아웃")
            }, label:{
                Image("logout")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(.black)
            })
        }//HStack End
        .background(.white)
    }//TopView End
    
    private var ContentView: some View {
        VStack {
            Spacer().frame(height:41)
            
            infoView
            
            Spacer()
            
            payView
            
            Spacer()
            
            supportView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 41)
                .background(.otherback)
    }
    
    private var infoView: some View {
        VStack{
            HStack {
                Text("\(nickname.isEmpty ? "(작성한 닉네임)" : nickname)")
                    .foregroundStyle(.login)
                    .font(.PretendardSemibold24)
                
                Text("님")
                    .foregroundStyle(.black)
                    .font(.PretendardSemibold24)
            }//HStack End
            
            VStack {
                Text("환영합니다! 🙌🏻")
                    .foregroundStyle(.black)
                    .font(.PretendardSemibold24)
            }//VStack End
            
            Spacer().frame(height: 25)
            HStack {
                InfoButton(image: .starhistory, title: "별 히스토리")
                InfoButton(image: .myreceipt, title: "전자영수증")
                InfoButton(image: .my, title: "나만의 메뉴")
            }//HStack End
        }//VStack End
    }//infoView End
    struct InfoButton: View {
        let image: ImageResource
        let title: String
        var body: some View {
            Button(action: {
                print(title)
            }) {
                VStack(spacing: 4) {
                    Spacer().frame(height: 19)
                    Image(image)
                    Text(title)
                        .font(.PretendardSemibold16)
                        .foregroundStyle(Color.black)
                    Spacer().frame(height: 19)
                }
                .frame(width: 102, height: 108)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
            }
        }
    }
    private var payView: some View {
        VStack(alignment: .leading) {
            Text("Pay")
                .font(.PretendardSemibold18)
                .foregroundStyle(.black)
            Spacer().frame(height: 8)
            
            HStack {
                listItem(image: .card, title: "스타벅스 카드 등록")
                Spacer()
                
                listItem(image: .cardChange, title: "카드 교환권 등록")
            }
            Spacer().frame(height:32)
            
            HStack {
                listItem(image: .coupon, title: "쿠폰 등록")
                Spacer()
                
                listItem(image: .couponHistory, title: "쿠폰 히스토리")
            }
            
            Spacer().frame(height:16)
        }
        .overlay(alignment: .bottom) {
            Divider()
                .background(Color.black.opacity(0.12))
        }
        .padding(.horizontal, 10)
    }
    
    private var supportView: some View {
        VStack (alignment: .leading) {
            Text("고객지원")
                .font(.PretendardSemibold18)
                .foregroundStyle(.black)
            Spacer().frame(height: 8)
            
            HStack {
                listItem(image: .storeCare, title: "스토어 케어")
                Spacer()
                
                listItem(image: .customerSound, title: "고객의 소리")
            }
            
            Spacer().frame(height: 32)
            
            HStack {
                listItem(image: .storeInfo, title: "매장 정보")
                Spacer()
                
                listItem(image: .returnInfo, title: "반납기 정보")
            }
            
            Spacer().frame(height: 32)
            
            HStack {
                listItem(image: .myreview, title: "마이 스타벅스 리뷰")
            }
            
            Spacer().frame(height: 16)
        }
        .padding(.horizontal, 10)
    }
    
    struct listItem: View{
        let image: ImageResource
        let title: String
        var body: some View {
            Button(action:{
                print(title)
            }) {
                HStack(spacing:4){
                    Image(image)
                    Text(title)
                        .font(.PretendardSemibold16)
                        .foregroundStyle(Color.black)
                }
                .frame(width: 157, height:32, alignment: .leading)
            }
        }
    }
}
#Preview {
    OtherView()
}
