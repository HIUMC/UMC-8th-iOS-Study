//
//  PayView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/31/25.
//
import SwiftUI

struct PayView: View {
    @StateObject var vm = PayViewModel()
    @State private var showCardRegister: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
         
            HStack {
                Text("Pay")
                    .font(.mainTextBold24)
                Spacer()
                Button(action: {
                    showCardRegister = true
                    // + 버튼 액션 (카드 추가 등)
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(8)
                        //.background(Color(.systemGray6))
                        .clipShape(Circle())
                }
                .sheet(isPresented: $showCardRegister){
                    CardRegisterView()
                    
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            // ------- 카드 Carousel -------
            TabView(selection: $vm.selectedIndex) {
                ForEach(vm.cards.indices, id: \.self) { idx in
                    Image(vm.cards[idx].imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(16)
                        .padding()
                        .tag(idx)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)
            .onChange(of: vm.selectedIndex) { newValue in
                vm.selectCard(newValue)
            }
            
            // ------- 카드 정보 -------
            VStack(spacing: 12) {
                Text(vm.cards[vm.selectedIndex].name)
                    .font(.mainTextMedium16)
                    .foregroundColor(Color("gray06"))
                Text("\(vm.cards[vm.selectedIndex].price)원")
                    .font(.mainTextSemiBold18)
                    .foregroundColor(Color("black03"))
                Text(vm.maskedNumber(vm.cards[vm.selectedIndex].cardNumber))
                    .font(.mainTextRegular13)
                Group {
                    if vm.cards[vm.selectedIndex].remainingSeconds > 0 {
                        HStack(spacing: 4) {
                            Text("카드 유효 시간")
                                .font(.mainTextRegular12)
                                .foregroundColor(Color("gray06"))
                            Text(vm.formattedTime(vm.cards[vm.selectedIndex].remainingSeconds))
                                .foregroundColor(Color("green01"))
                                .font(.mainTextRegular12)
                        }
                    } else {
                        Text(vm.formattedTime(vm.cards[vm.selectedIndex].remainingSeconds))
                            .foregroundColor(.red)
                            .font(.subheadline.bold())
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 32)
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color(.systemBackground))
    }
}

#Preview{
    PayView()
}
