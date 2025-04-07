//
//  Button.swift
//  Starbucks
//
//  Created by nau on 3/26/25.
//

import SwiftUI

struct Buttons: View {
    @State private var selectedTemp: CoffeeTemperature = .hot
    
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
                print("")
            }, label: {
                Text("")
            }).buttonStyle(mainBtnStyle())
            
            Button(action: {
                print("")
            }, label: {
                Text("")
            }).buttonStyle(otherTopBtnStyle())
            
            temperatureToggleBtn(selected: $selectedTemp, availableTemps: [.hot, .iced])
        }
    }
}

//버튼스타일을 만들어 적용..
struct mainBtnStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.green01))
                .frame(maxHeight: 60)
            
            configuration.label
                .font(.makeMedium18)
                .foregroundColor(.white)
        }
    }
}

struct otherTopBtnStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.white))
                .shadow(color: Color(white: 0, opacity: 0.1), radius: 5)
                .frame(maxWidth: 102, maxHeight: 108)
            
            configuration.label
                .font(.mainTextSemibold16)
                .foregroundColor(Color(.black03))
    
        }
    }
}

struct temperatureToggleBtn: View {
    @Binding var selected: CoffeeTemperature
    let availableTemps: [CoffeeTemperature] // [.hot, .iced] 등

    var body: some View {
        ZStack {
            // 바탕 라운드 배경
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.gray07)
                .frame(height: 40)

            // 선택된 쪽 강조 배경 (슬라이더 느낌)
            HStack {
                if selected == .iced { Spacer() }

                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width / 2 , height: 40)
                    .shadow(radius: 3)

                if selected == .hot { Spacer() }
            }
            .animation(.easeInOut(duration: 0.25), value: selected)

            // HOT / ICED 버튼
            HStack {
                ForEach(availableTemps, id: \.self) { temp in
                    Button {
                        withAnimation {
                            selected = temp
                        }
                    } label: {
                        Text(temp.rawValue)
                            .font(.mainTextSemibold18)
                            .foregroundColor(selected == temp ? (temp == .hot ? .red : .blue) : .gray02)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(height: 40)
        }
    }
}

#Preview {
    Buttons()
}
