
//
//  DetailView.swift
//  Starbucks
//
//  Created by 고석현 on 4/5/25.
//

import SwiftUI

struct DetailCoffeeView: View {
    @State private var router = NavigationRouter()
    @Bindable var viewModel : HomeViewModel
    @State private var selectedTemp: DetailCoffeeModel.Temp = .hot //초기화~~
    
    var body: some View {
        NavigationStack(path: $router.path) {
            if let selectedCoffee = viewModel.selectedCoffeeModel {
                VStack{
                    ZStack {
                        selectedCoffee.Image
                            .ignoresSafeArea(edges: .top)
                        navBar
                    }
                    .frame(height: 355)
                    mainView(coffee: selectedCoffee)
                    
                    Spacer()
                    
                    orderButton
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .signup:
                        SignupView(signupViewModel: SignupViewModel())
                    case .tabBar:
                        TabBarView()
                    case .login:
                        LoginView()
                    case .detailCoffee:
                        DetailCoffeeView(viewModel: HomeViewModel())
                    case .ad:
                        AdView()
                    case.goToReceipt:
                        ReceiptView()
                    }
                }
            }
        }
        
    }
    
    private var navBar: some View {
        VStack {
            HStack {
                Button(action : {
                    router.pop()
                }) {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.black.opacity(0.4))
                        .background(
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                        )
                }
                Spacer()
                
                Button(action : {
                }) {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.black.opacity(0.4))
                        .background(
                            Image(systemName: "square.and.arrow.up")
                                .foregroundStyle(.white)
                        )
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
   
    
    private func mainView(coffee: DetailCoffeeModel) -> some View {
        VStack(alignment: .leading, spacing: 32) {
            titleGroup(coffee: coffee)
            
            contentGroup(coffee: coffee)
            
            if (coffee.hasBothTemps) {
                selectHotIced(coffee: coffee)
            } else {
                onlyHotIced(coffee: coffee)
            }
        }
        .padding(.horizontal, 10)
    }
        
    private func selectHotIced(coffee: DetailCoffeeModel) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.gray07)
                .frame(height: 36)
            
            HStack(spacing: 0) {
                Button {
                    selectedTemp = .hot
                } label: {
                    Text("HOT")
                        .font(.PretendardSemiBold18)
                        .foregroundColor(selectedTemp == .hot ? .red01.opacity(0.6) : .gray02)
                        .frame(maxWidth: .infinity, minHeight: 36)
                        .background {
                            Rectangle()
                                .fill(selectedTemp == .hot ? Color.white : Color.clear)
                                .cornerRadius(50)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 1)
                        }
                }
                
                Button {
                    selectedTemp = .iced
                } label: {
                    Text("ICED")
                        .font(.PretendardSemiBold18)
                        .foregroundColor(selectedTemp == .iced ? .blue01.opacity(0.6) : .gray02)
                        .frame(maxWidth: .infinity, minHeight: 36)
                        .background {
                            Rectangle()
                                .fill(selectedTemp == .iced ? Color.white : Color.clear)
                                .cornerRadius(50)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 1)
                        }
                }
            }
        }
    }

        
    private func onlyHotIced(coffee: DetailCoffeeModel) -> some View {
        Text(selectedTemp == .hot ? "HOT ONLY" : "ICED ONLY")
            .font(.PretendardBold18)
            .foregroundColor(selectedTemp == .hot ? .red01.opacity(0.6) : .blue01.opacity(0.6))
            .frame(maxWidth: .infinity, minHeight: 36)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(.white)
                    .stroke(.gray)
            }
    }
        
    // 커피 이름 및 영어 이름
    private func titleGroup(coffee: DetailCoffeeModel) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Text(coffee.name)
                    .foregroundStyle(.black03)
                    .font(.PretendardSemiBold24)
                    
                Image("new")
            }
            .padding(.leading,15)
            HStack {
                Text(coffee.nameEn)
                    .foregroundStyle(.gray01)
                    .font(.PretendardSemiBold18)
            }
            .padding(.leading,15)
        }
    }
        
    // 커피 설명 및 가격
    private func contentGroup(coffee: DetailCoffeeModel) -> some View {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(coffee.content)
                        .foregroundStyle(.gray06)
                        .font(.PretendardSemiBold14)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                }
                .padding(.leading,5)
                
                
                HStack {
                    Text(coffee.price + "원")
                    
                        .font(.PretendardBold24)
                }
                .padding(.leading,10)
            }.frame(width: 420, height: 96)

    }
        
    // 주문하기
    private var orderButton: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .ignoresSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: 80)
                
            Button(action: {
                print("주문하기")
            }, label: {
                Text("주문하기")
                    .font(.PretendardMedium16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 383, maxHeight: 43)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.green01)
                    )
            })
        }
    }
}

#Preview {
    DetailCoffeeView(viewModel: HomeViewModel())
}
