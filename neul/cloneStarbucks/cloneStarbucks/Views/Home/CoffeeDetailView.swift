//
//  CoffeeDetailView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//

import SwiftUI

struct CoffeeDetailView: View {
    @State var isIce: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Image(.coffeeDetail1)
            middleInfo
            Spacer()
            bottomButton
        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(.back)
                        .resizable()
                        .frame(width: 32, height: 32)
                }

            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("share")
                } label: {
                    Image(.share)
                        .resizable()
                        .frame(width: 32, height: 32)
                }

            }
        }
        
    }
    
    private var middleInfo: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: 5) {
                        Text("title")
                            .foregroundStyle(.black03)
                            .font(.MainTextSemiBold24)
                        Image(.new)
                    }
                    .padding(.top, 20)
                    Text("english")
                        .foregroundStyle(.gray01)
                        .font(.MainTextSemiBold14)
                    Spacer().frame(height: 50)
                    Text ("description")
                        .foregroundStyle(.gray06)
                        .font(.MainTextSemiBold14)
                    Spacer().frame(height: 20)
                    Text("price")
                        .foregroundStyle(.black)
                        .font(.MainTextBold24)
                }
                .padding(.leading, 20)

                Spacer()
            }
            Spacer()
            pickerView
        }
        .frame(height: 256)
        
        
    }
    
    private var bottomButton: some View {
        ZStack {
            Color.white
                .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: -3)
                .frame(maxWidth: .infinity, minHeight: 73)
            RoundedRectangle(cornerRadius: 999)
                .fill(.green00)
                .frame(width: 383, height: 43)
                .overlay {
                    Text("주문하기")
                        .foregroundStyle(.white)
                        .font(.MainTextMedium16)
                }
                
        }
        .frame(maxWidth: .infinity, maxHeight: 78)
        .padding(.bottom, 10)
    }
    
            
    
    private var pickerView: some View {
        GeometryReader { geometry in
            let barWidth = geometry.size.width
            ZStack(alignment: .leading) {
                // 배경 바
                RoundedRectangle(cornerRadius: 999)
                    .fill(.gray07)
                    .frame(height: 36)
                    .onTapGesture {
                        isIce.toggle()
                    }

                // 채워진 부분
                RoundedRectangle(cornerRadius: 999)
                    .fill(Color.white)
                    .frame(width: geometry.size.width * (1/2), height: 36)
                    .offset(x: isIce ? barWidth - barWidth/2 : 0)
                    .animation(.easeInOut, value: 1)
                    .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 1)
                
                HStack(alignment: .center) {
                    Text("HOT")
                        .foregroundStyle(isIce ? .gray02: .red01)
                        .font(.MainTextSemiBold18)
                    Spacer()
                    Text("ICED")
                        .foregroundStyle(isIce ? Color(hex: "0021FB").opacity(0.63): .gray02)
                        .font(.MainTextSemiBold18)
                    
                }
                .padding(.horizontal, 70)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 36)
        .padding(.horizontal, 20)
    }
}





#Preview {
    CoffeeDetailView()
}
