//
//  DetailView.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import SwiftUI

struct CoffeeDetailView: View {
    @Bindable var viewModel : HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if let selectedCoffee = viewModel.selectedCoffeeModel {
            VStack{
                ZStack {
                    selectedCoffee.image
                        .ignoresSafeArea(edges: .top)
                    navBar
                }
                .frame(height: 355)
                contentView(coffee: selectedCoffee)
                
                Spacer()
                
                orderButton
            }
        }
    }
    
    private var navBar: some View {
        VStack {
            HStack {
                Button(action : {
                    dismiss()
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
    
    @State private var selectedTemp: CoffeeModel.Temp = .hot  // 초기값 설정
    
    private func contentView(coffee: CoffeeModel) -> some View {
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
        
    private func selectHotIced(coffee: CoffeeModel) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.gray07)
                .frame(height: 36)
                
            HStack(spacing: 0) {
                Text("HOT")
                    .font(.pretendardSemiBold(18))
                    .foregroundColor(selectedTemp == .hot ? .red01.opacity(0.6) : .gray02)
                    .frame(maxWidth: .infinity, minHeight: 36)
                    .background {
                        Rectangle()
                            .fill(selectedTemp == .hot ? Color.white : Color.clear)
                            .cornerRadius(50)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 1)
                    }
                    
                Text("ICED")
                    .font(.pretendardSemiBold(18))
                    .foregroundColor(!(selectedTemp == .hot) ? .blue01.opacity(0.6) : .gray02)
                    .frame(maxWidth: .infinity, minHeight: 36)
                    .background {
                        Rectangle()
                            .fill(!(selectedTemp == .hot) ? Color.white : Color.clear)
                            .cornerRadius(50)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 1)
                    }
            }
        }
    }
        
    private func onlyHotIced(coffee: CoffeeModel) -> some View {
        Text(selectedTemp == .hot ? "HOT ONLY" : "ICED ONLY")
            .font(.pretendardBold(15))
            .foregroundColor(selectedTemp == .hot ? .red01.opacity(0.6) : .blue01.opacity(0.6))
            .frame(maxWidth: .infinity, minHeight: 36)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(.white)
                    .stroke(.gray)
            }
    }
        
    // 커피 이름
    private func titleGroup(coffee: CoffeeModel) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Text(coffee.name)
                    .foregroundStyle(.black03)
                    .font(.pretendardSemiBold(24))
                    
                Image("new")
            }
            Text(coffee.nameEn)
                .foregroundStyle(.gray01)
                .font(.pretendardSemiBold(14))
        }
    }
        
    // 커피 설명 및 가격
    private func contentGroup(coffee: CoffeeModel) -> some View {
            VStack(alignment: .leading, spacing: 20) {
                Text(coffee.content)
                    .foregroundStyle(.gray06)
                    .font(.pretendardSemiBold(14))

                    .lineLimit(nil)
                
                Text(coffee.price + "원")
                    .foregroundStyle(.gray01)
                    .font(.pretendardBold(24))
            }.frame(width: 420, height: 96)

    }
        
    // 주문하기 버튼
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
                    .font(.mainTextMedium16)
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
    CoffeeDetailView(viewModel: HomeViewModel())
}
