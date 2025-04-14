//
//  DetailMenuView.swift
//  Starbucks
//
//  Created by nau on 4/3/25.
//

import SwiftUI

struct DetailMenuView: View {
    
    @State private var selectedTemp: CoffeeTemperature
    
    @Environment(\.dismiss) private var dismiss
    @Environment(NavigationRouter.self) var router
    @Environment(DetailMenuViewModel.self) var viewModel
  
    init(menu: DetailMenuModel, defaultTemp: CoffeeTemperature? = nil) {
        _selectedTemp = State(initialValue: defaultTemp ?? menu.temperatures.first ?? .hot)
    }
    
    var body: some View {
        let menu = viewModel.currentMenu
        
        VStack {
            ZStack(alignment: .top) {
                Image(menu.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenSize.width)
                    .ignoresSafeArea()
                
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(.detailBtn1)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(.detailBtn2)
                    })
                }.padding(.horizontal, 8)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text(menu.menuName)
                    .font(.mainTextSemibold24)
                    .foregroundStyle(.black03)
                
                Text(menu.menuNameEn)
                    .font(.mainTextSemibold14)
                    .foregroundStyle(.gray01)
                    .offset(y: -10)
                
                Text(menu.menuDescription)
                    .font(.mainTextSemibold14)
                    .foregroundStyle(.gray06)
                    .frame(height: 55)
                
                Text(menu.price)
                    .font(.mainTextBold24)
                    .foregroundStyle(.black03)
                
                Button(action: {
                    
                }, label: {
                    if selectedTemp == .hotonly {
                        temperatureToggleBtn(selected: $selectedTemp, onTempChange: handleTemperatureChange, availableTemps: [.hotonly])
                    } else if selectedTemp == .icedonly {
                        temperatureToggleBtn(selected: $selectedTemp, onTempChange: handleTemperatureChange, availableTemps: [.icedonly])
                    } else {
                        temperatureToggleBtn(selected: $selectedTemp, onTempChange: handleTemperatureChange, availableTemps: [.hot, .iced])
                    }
                })
            }
            .padding(.horizontal, 10)
            
        }.frame(maxHeight: 631)
            .navigationBarBackButtonHidden()
            .toolbar(.hidden, for: .tabBar)
        
        Spacer().frame(maxHeight: 200)
        
        bottomView
    }
    
    private var bottomView : some View {
        VStack(spacing: 15) {
            Divider()
                .shadow(radius: 0.5)
            
            Button(action: {
                print("주문하기")
            }, label: {
                Text("주문하기")
            }).buttonStyle(mainBtnStyle())
                .frame(maxWidth: 383 ,maxHeight: 43)
                .clipShape(.capsule)
        }.ignoresSafeArea()
    }
    
    // 온도 변경 처리
    func handleTemperatureChange(to newTemp: CoffeeTemperature) {
        // 이미 현재 선택된 온도면 동작 X
        guard newTemp != selectedTemp else { return }
   
        selectedTemp = newTemp
        
        // 현재 메뉴 이름과 동일하면서, 다른 온도 지원하는 메뉴가 있으면 전환
        if let newMenu = viewModel.findMenu(for: newTemp) {
            router.pop()
            router.push(.detail(newMenu))
        }
    }
}
