//
//  CoffeeView.swift
//  Starbucks
//
//  Created by 이가원 on 4/5/25.
//

import SwiftUI

struct CoffeeDetailView: View {
    let coffee: Coffee
    @State private var selectedTemp: TempOption = .hot

    var body: some View {
        ZStack(alignment: .topLeading){
            VStack {
                Image(coffee.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 440)
                    .padding(.bottom, 20)

                title
                Spacer().frame(height:32)
                bottom
                Spacer().frame(height:32)
                tempOptionView
                Spacer()
                button
                Spacer().frame(height: 14)
        }
            Image(.back)
                .padding(.leading, 4)
                .padding(.top, 40)

        }
        .ignoresSafeArea()
    }
    private func labelOption(text: String, color: Color) -> some View {
        Text(text)
            .font(.custom("Pretendard-Bold", size: 15))
            .foregroundColor(color)
            .frame(width: 420, height: 36)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 99)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
    }
    private var title: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(coffee.name)
                    .font(.custom("Pretendard-SemiBold", size: 24))
                Image(.new)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .padding(.bottom, 4)

            Text(coffee.engName)
                .font(.custom("Pretendard-SemiBold", size: 14))
                .foregroundStyle(.gray1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
        }
    }

    private var bottom: some View {
        VStack {
            Text(coffee.text)
                .font(.custom("Pretendard-SemiBold", size: 14))
                .foregroundStyle(.gray6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.bottom, 20)

            Text("\(coffee.price)원")
                .font(.custom("Pretendard-SemiBold", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
        }
    }

    private var tempOptionView: some View {
        switch coffee.option {
        case .hotIced:
            return AnyView(hotIcedSelector)
        case .hotOnly:
            return AnyView(labelOption(text: "HOT ONLY", color: .red.opacity(0.63)))
        case .icedOnly:
            return AnyView(labelOption(text: "ICED ONLY", color: .blue.opacity(0.63)))
        }
    }

    private var hotIcedSelector: some View {
        ZStack(alignment: selectedTemp == .hot ? .leading : .trailing) {
            RoundedRectangle(cornerRadius: 99)
                .fill(Color.gray07)
                .frame(width: 420, height: 36)

            RoundedRectangle(cornerRadius: 99)
                .fill(Color.white)
                .frame(width: 208, height: 36)
                .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 1)
                .animation(.easeInOut, value: selectedTemp)

            HStack(spacing: 0) {
                Button(action: {
                    withAnimation {
                        selectedTemp = .hot
                    }
                }) {
                    Text("HOT")
                        .frame(width: 208, height: 36)
                        .foregroundColor(selectedTemp == .hot ? .red.opacity(0.63) : .gray02)
                        .font(.custom("Pretendard-SemiBold", size: 18))
                }

                Button(action: {
                    withAnimation {
                        selectedTemp = .iced
                    }
                }) {
                    Text("ICED")
                        .frame(width: 208, height: 36)
                        .foregroundColor(selectedTemp == .iced ? .blue.opacity(0.63) : .gray02)
                        .font(.custom("Pretendard-SemiBold", size: 18))
                }
            }
        }
    }

    private var button: some View {
        Button(action: {
            print("주문하기")
        }) {
            Text("주문하기")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: 383, minHeight: 43)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 99))
                .padding(.horizontal)
        }
        .frame(width: 439, height: 73)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: Color.black.opacity(0.04), radius: 7, x: 0, y: -3)
    }
}
enum TempOption {
    case hot
    case iced
}

#Preview {
    let viewModel = CoffeeViewModel()
    return CoffeeDetailView(coffee: viewModel.coffeeList[3])
}
