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
    @EnvironmentObject var viewModel: CoffeeDetailViewModel
    let coffee: CoffeeDetailModel
    
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
                        .renderingMode(.original)
                        .frame(width: 32, height: 32)
                }

            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("share")
                } label: {
                    Image(.share)
                        .resizable()
                        .renderingMode(.original)
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
                        Text(coffee.title)
                            .foregroundStyle(.black03)
                            .font(.MainTextSemiBold24)
                        Image(.new)
                    }
                    .padding(.top, 20)
                    Text(coffee.englishName)
                        .foregroundStyle(.gray01)
                        .font(.MainTextSemiBold14)
                    Spacer().frame(height: 20)
                    Text (coffee.descrip)
                        .foregroundStyle(.gray06)
                        .font(.MainTextSemiBold14)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer().frame(height: 20)
                    Text("\(coffee.price)원")
                        .foregroundStyle(.black)
                        .font(.MainTextBold24)
                }
                .padding(.leading, 20)

                Spacer()
            }
            Spacer()
            
            switch coffee.temp.count {
            case 1:
                SingleTempView(coffee: coffee)
            default:
                PickTempView(isIce: $isIce)
            }
            
        }
        .frame(height: 256)
        
        
    }
    
    private var bottomButton: some View {
        ZStack {
            Color.white
                .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: -3)
                .frame(maxWidth: .infinity, minHeight: 73)
            Button(action: {
                print("주문하기")
            }, label:  {
                RoundedRectangle(cornerRadius: 999)
                    .fill(.green00)
                    .frame(width: 383, height: 43)
                    .overlay {
                        Text("주문하기")
                            .foregroundStyle(.white)
                            .font(.MainTextMedium16)
                    }
            })
            
                
        }
        .frame(maxWidth: .infinity, maxHeight: 78)
        .padding(.bottom, 10)
    }
    
            
    
    
    
        
}






struct CoffeeDetailView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            CoffeeDetailView(coffee: CoffeeDetailViewModel().coffees[0])
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
