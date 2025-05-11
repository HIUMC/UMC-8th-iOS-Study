//
//  CoffeeDetailView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/3/25.
//

import SwiftUI

struct CoffeeDetailView: View {
    @Bindable var viewModel: HomeViewModel
    
    @EnvironmentObject private var router: NavigationRouter
    @Environment(\.dismiss) var dismiss
    
    @State private var isHot = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let selectedCoffee = viewModel.selectedCoffee {
                Image(selectedCoffee.returnCoffeeImg())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 355)
                
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 8) {
                            Text(selectedCoffee.returnCoffeeName())
                                .font(.mainTextSemiBold24)
                                .foregroundStyle(Color("black03"))
                            Image(.new)
                        }
                        Text(selectedCoffee.returnCoffeeNameEng())
                            .font(.mainTextSemiBold14)
                            .foregroundStyle(Color("gray01"))
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text(selectedCoffee.returnCoffeeDetail())
                            .font(.mainTextSemiBold14)
                            .foregroundStyle(Color("gray06"))
                        
                        Text(selectedCoffee.returnCoffeePrice())
                            .font(.mainTextBold24)
                            .foregroundStyle(Color("black03"))
                    }
                    
                    HStack {
                        
                    }
                }
                .padding(.horizontal, 20)
                
                if selectedCoffee.returnCoffeeType().contains([.hot, .ice]) {
                    both
                } else if selectedCoffee.returnCoffeeType().contains([.hot]) {
                    only("HOT")
                } else {
                    only("ICED")
                }
                
                Spacer()
                
                Rectangle()
                    .fill(Color("gray01"))
                    .frame(height: 0.5)
                
                Button(action: {
                    print("주문하기")
                }, label: {
                    Text("주문하기")
                        .font(.mainTextMedium16)
                        .foregroundStyle(Color("white00"))
                        .frame(maxWidth: .infinity, maxHeight: 43)
                        .background() {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("green00"))
                                .frame(height: 43)
                        }
                })
                .padding(.horizontal, 28)
                .padding(.bottom, 32)
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
//                    router.pop()
                }) {
                    Image(.back)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    print("share 버튼 클릭")
                }) {
                    Image(.share)
                }
            }
        })
    }
    
    private var both: some View {
        GeometryReader { geometry in
            ZStack(alignment: isHot ? .leading : .trailing) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("gray07"))
                    .frame(height: 36)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("white00"))
                    .frame(width: (geometry.size.width - 20) / 2, height: 36)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 1)
                
                HStack {
                    Group {
                        Text("HOT")
                            .foregroundStyle(isHot ? Color("red01") : Color("gray02"))
                            
                        
                        Text("ICED")
                            .foregroundStyle(isHot ? Color("gray02") : Color("blue01"))
                    }
                    .font(.mainTextSemiBold18)
                    .frame(maxWidth: (geometry.size.width - 20) / 2)
                }
            }
            .onTapGesture {
                withAnimation(.easeIn) {
                    isHot.toggle()
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func only(_ type: String) -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("white00"))
                    .stroke(Color("gray01"))
                    .frame(height: 36)
                Text("\(type) ONLY")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(type == "HOT" ? Color("red01") : Color("blue01"))
                }
                .padding(.horizontal, 20)
        }
    }
}
