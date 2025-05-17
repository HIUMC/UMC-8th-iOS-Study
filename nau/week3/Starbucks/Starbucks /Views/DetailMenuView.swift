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
    
    let menu: DetailMenuModel
    
    init(menu: DetailMenuModel, defaultTemp: CoffeeTemperature? = nil) {
        self.menu = menu
        _selectedTemp = State(initialValue: defaultTemp ?? menu.temperatures.first ?? .hot)
    }
    
    var body: some View {
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
            
            Spacer()
            
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
           
                
                Text(menu.price)
                    .font(.mainTextBold24)
                    .foregroundStyle(.black03)
                
                Button(action: {
                    
                }, label: {
                    temperatureToggleBtn(selected: $selectedTemp, availableTemps: [.hot, .iced])
                })
            }
            .padding(.horizontal, 10)
            
        }.frame(maxHeight: 631)
            .navigationBarBackButtonHidden()
            .toolbar(.hidden, for: .tabBar)
        
        Spacer().frame(maxHeight: 200)
        
        bottomView
    }
    /*
    private func findMenu(sameAs base: DetailMenuModel, with temp: CoffeeTemperature) -> DetailMenuModel? {
        let allMenus = DetailMenuViewModel().detailMenuModel
        return allMenus.first {
            $0.menuName == base.menuName.replacingOccurrences(of: "아이스 ", with: "") && $0.temperatures.contains(temp)
        }
    }*/
    
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
}
