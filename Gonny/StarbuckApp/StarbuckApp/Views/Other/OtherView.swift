//
//  OtherView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/31/25.
//
import SwiftUI
import Observation

struct OtherView: View {
    @StateObject private var viewModel = OtherViewModel()
    @AppStorage("isLoggedIn") var isLoggedIn = false
    //@State private var isNavigatingToFindStore = false
    
    var body: some View {
        NavigationStack{
                VStack{
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Other")
                                .font(.mainTextBold24)
                                .foregroundColor(Color("black03"))
                                .padding(.top, 24)
                            // .padding(.leading, 23.5)
                            Spacer()
                            
                            Button(action: {
                                print("로그아웃")
                                isLoggedIn = false
                            }) {
                                Image("logout")
                                    .padding(.horizontal, 23.5)
                                    .padding(.top, 24)
                            }
                        }
                        .padding(.horizontal)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(viewModel.savednickname.isEmpty ? "(작성한 닉네임)" : viewModel.savednickname)")
                            .foregroundStyle(Color("green01"))
                            .font(.mainTextSemiBold24)
                        +
                        Text(" 님")
                            .foregroundColor(Color("green01"))
                            .font(.mainTextSemiBold24)
                        
                        Text("환영합니다! 🙌")
                            .foregroundColor(Color("black02"))
                            .font(.mainTextBold24)
                        // .multilineTextAlignment(.center)
                        
                    }
                    //.multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top,41)
                    HStack {
                        SelecView(text: "별 히스토리", destination: StarHistoryView())
                        SelecView(text: "전자영수증", destination: ReceiptView())
                        SelecView(text: "나만의 메뉴", destination: MyOwnMenuView())
                    }
                    .padding(.horizontal)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    VStack() {
                        Text("Pay")
                            .font(.mainTextSemiBold18)
                            .foregroundColor(Color("black03"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer().frame(height: 24)
                        VStack(spacing:32) {
                            
                            HStack() {
                                leftImageView(text:"스타벅스 카드 등록")
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                Spacer()
                                leftImageView(text:"카드 교환권 등록")
                                .frame(maxWidth: .infinity)}
                            
                            
                            HStack() {
                                leftImageView(text:"쿠폰 등록")
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                Spacer()
                                leftImageView(text:"쿠폰 히스토리")
                                .frame(maxWidth: .infinity)}
                            
                        }
                        Rectangle()
                            .frame(height: 0.7)
                            .padding(.bottom, 49)
                            .foregroundStyle(Color.black.opacity(0.12))
                        
                        Text("고객지원")
                            .font(.mainTextSemiBold18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer().frame(height: 24)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            HStack() {
                                leftImageView(text:"스토어 케어")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                                leftImageView(text:"고객의 소리")
                                    .frame(maxWidth: .infinity)
                            }
                            
                            
                            HStack() {
                                NavigationLink(destination: FindStoreView()){
                                    leftImageView(text:"매장 정보")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                                Spacer()
                                
                                leftImageView(text:"반납기 정보")
                                    .frame(maxWidth: .infinity)
                            }
                            
                        }
                    
                        
                        HStack() {
                            leftImageView(text:"마이 스타벅스 리뷰")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("")
                            
                        }
                        Spacer().frame(height:57)
                        
                    }
                }
            }
        
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("white01"))
        }
        
        
        
    }


struct SelecView<Destination: View>: View {
    var text: String
    var destination: Destination?

    var body: some View {
        if let destination = destination {
            NavigationLink(destination: destination) {
                cardView
            }
        } else {
            Button(action: {
                print("\(text) 버튼 눌림")
            }) {
                cardView
            }
        }
    }

    private var cardView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color("white01"))
            .frame(width: 102, height: 108)
            .overlay(
                VStack(spacing: 8) {
                    Image(selectImage(text))
                    Text(text)
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(Color("black03"))
                }
            )
    }

    private func selectImage(_ text: String) -> String {
        switch text {
        case "별 히스토리": return "star_history"
        case "전자영수증": return "receipt"
        case "나만의 메뉴": return "my_menu"
        default: return "pay"
        }
    }
}
struct leftImageView : View {
            var text: String
            var body: some View {
                    HStack {
                        Image(payImage(text))
                        
                        Text(text)
                            .font(.mainTextSemiBold16)
                            .foregroundStyle(Color("black02"))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            
            func payImage(_ text: String) -> String{
                switch text  {
                case "스타벅스 카드 등록":
                    return "card"
                case "쿠폰 등록" :
                    return "coupon"
                case "카드 교환권 등록":
                    return "card_change"
                case "쿠폰 히스토리":
                    return "coupon_history"
                case "스토어 케어":
                    return "store_care"
                case "고객의 소리":
                    return "customer_sound"
                case "매장 정보":
                    return "location"
                case "마이 스타벅스 리뷰" :
                    return "review"
                case "반납기 정보":
                    return "return_info"
                default:
                    return "pay"
                }
            }
        





#Preview{
    NavigationStack{
        OtherView()
    }
}
            
                            
