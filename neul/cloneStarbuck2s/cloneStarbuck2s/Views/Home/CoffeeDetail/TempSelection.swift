//
//  TempSelection.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/5/25.
//
import SwiftUI

struct PickTempView: View {
    @Binding var isIce: Bool
    
    var body: some View {
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

struct SingleTempView: View {
    let coffee: CoffeeDetailModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 999)
                .stroke(.gray01, lineWidth: 1)
                .fill(.white)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, maxHeight: 36)
                
            Text(coffee.temp[0].rawValue)
                .foregroundStyle(coffee.temp[0].returnColor())
                .font(.pretend(type: .bold, size: 15))
        }
    }
}
