//
//  CoffeeDetailView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/5/25.
//
//실제 구현하는 화면인거지
import SwiftUI

struct CoffeeDetailView: View {
    @StateObject private var viewModel: CoffeeDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    // View의 상단에 넣어야 함
    private var temperatureSelectionView: some View {
        switch viewModel.coffee.temperatureOption {
        case .both:
            return AnyView(
                HStack(spacing: 16) {
                    TemperatureButton(
                        label: "HOT",
                        isSelected: viewModel.coffee.selectedTemperature == .hot,
                        color: .red
                    ) {
                        viewModel.selectTemperature(.hot)
                    }

                    TemperatureButton(
                        label: "ICED",
                        isSelected: viewModel.coffee.selectedTemperature == .iced,
                        color: .blue
                    ) {
                        viewModel.selectTemperature(.iced)
                    }
                }
            )

        case .hotOnly:
            return AnyView(
                Text("HOT only")
                    .font(.mainTextSemiBold14)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
                    .foregroundColor(.red)
            )

        case .icedOnly:
            return AnyView(
                Text("ICED only")
                    .font(.mainTextSemiBold14)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .foregroundColor(.blue)
            )
        }
    }

    init(coffee: CoffeeItem) {
        _viewModel = StateObject(wrappedValue: CoffeeDetailViewModel(coffee: coffee))
    }

    
    let SampleCoffee1 = CoffeeItem(korName: "아이스 카라멜 마끼야또",
                                   engName: "Iced Caramel Macchiato", imageName: "CaramelCold",
                                   description: "향긋한 바닐라 시럽과 시원한 우유에 얼음을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: 6100, temperature: .iced, temperatureOption: .both, selectedTemperature: .iced)
    let SampleCoffee2 = CoffeeItem(korName: "카라멜 마끼야또", engName: "Caramel Macchiato", imageName: "CaramelMacchiato",
                                   description: "향긋한 바닐라 시럽과 스팀 밀크 위에 풍성한 우유 커품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피음료", price: 6100, temperature: .hot, temperatureOption: .both, selectedTemperature: .hot)
    let SampleCoffee3 = CoffeeItem(korName: "아이스 아메리카노", engName: "Iced Caffe Ameriano", imageName:"IceAmericano",
                                   description: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피 ", price: 4700, temperature: .iced, temperatureOption: .both, selectedTemperature: .iced)
    let SampleCoffee4 = CoffeeItem(korName: "카페 아메리카노", engName: "Caffe Americano", imageName: "HotAmericano",
                                   description: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피", price: 4700, temperature: .hot, temperatureOption: .both, selectedTemperature: .iced)
    let SampleCoffee5 = CoffeeItem(korName: "에스프레소 콘 파나", engName: "Espresso Con Panna", imageName: "EspressoConpanna",description: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크립의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, temperature: .hot, temperatureOption: .hotOnly, selectedTemperature: .hot)

    let SampleCoffee6 = CoffeeItem(korName: "에스프레소 마끼야또", engName: "Espresso Macchiato", imageName: "EspressoMacchiato",
                                   description: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: 3900, temperature: .iced, temperatureOption: .icedOnly, selectedTemperature: .iced)
    
   
                
var body: some View {
    VStack( spacing: 20) {
        HStack {
            //뒤로가기 버튼
            Button(action: {
                dismiss()
            }) {
                Image("backButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width:30, height:30)
                    .padding(.leading, 8)
            }
            Spacer()
            
            Button(action:{}){
                Image("shareButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width:30, height: 30)
                    .padding(.trailing,8)
            }
        }
                Image(viewModel.coffee.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 440, height: 335)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    //.ignoresSafeArea(edges: .top)//이거 왜 안 돼요??????????
            
            // 이름(한국어+영어)
        VStack(spacing: 4) {
                Text(viewModel.coffee.korName)
                    .font(.mainTextSemiBold24)
                    .foregroundColor(Color("black03"))
                    

                Text(viewModel.coffee.engName)
                    .font(.mainTextSemiBold14)
                    .foregroundColor(Color("gray01"))
            }
        
            // 설명
            Text(viewModel.coffee.description)
                .font(.mainTextSemiBold14)
                .foregroundColor(Color("gray06"))
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)

            // 가격 및 온도
            VStack(spacing: 12) {
                Text("\(viewModel.coffee.price)원")
                    .font(.mainTextBold24)
                    .foregroundColor(Color("black03"))
                
           //여기 수정해야하는데,,,일단 시간이슈로 패스
                temperatureSelectionView
                
               /* Text(viewModel.coffee.temperature == .iced ? "ICED" : "HOT")
                    .font(.mainTextSemiBold14)
                    .foregroundColor(viewModel.coffee.temperature == .iced ? .blue : Color("red01"))//Color확장 했는데 왜 이러는거얌...
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    */
            }

            Spacer()

            // 주문 버튼
            Button(action: {}) {
                Text("주문하기")
                    .font(.mainTextMedium16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(Color("green00"))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 14)
            }

            Spacer()
        }
      
        //.padding(.top, 40)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
   
}


struct TemperatureButton: View {
    let label: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.mainTextSemiBold14)
                .foregroundColor(isSelected ? .white : color)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(isSelected ? color : Color.gray.opacity(0.1))
                .cornerRadius(10)
        }
    }
}

#Preview {
    CoffeeDetailView(coffee: CoffeeItem(
        korName: "아이스 카라멜 마끼야또",
        engName: "Iced Caramel Macchiato",
        imageName: "CaramelCold",
        description: "향긋한 바닐라 시럽과 시원한 우유에 얼음을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료",
        price: 6100,
        temperature: .iced,
        temperatureOption: .both,
                selectedTemperature: .iced
    ))
}
