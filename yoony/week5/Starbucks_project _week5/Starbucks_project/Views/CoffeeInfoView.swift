//
//  CoffeeDetailView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/3/25.
//

import SwiftUI

struct CoffeeInfoView: View {
    let coffee: Coffee
    @State private var selectedType: CoffeeType?
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel = CoffeeViewModel()
    
    

    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(.back)
                }
                

                Spacer()
                
                Button(action:{}) {
                    Image(.share)
                        .font(.title)
                        .foregroundColor(.black)
                }
            } //hstack
            Spacer()
            
                VStack {
                    
                    Image(coffee.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 440, height: 355)
                        .ignoresSafeArea()
                    
                    Spacer().frame(height: 20)
                    
                    VStack(alignment: .leading) {
                        
                        HStack{
                            
                            Text(coffee.name)
                                .font(.title)
                                .bold()
                            
                            Image(.new)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 6.5)
                            
                        }
                        Spacer().frame(height: 4)
                        
                        Text(coffee.englishName)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer().frame(height: 22)
                        
                        Text(coffee.description)
                            .font(.body)
                        
                        Spacer().frame(height: 20)
                        
                        Text("\(coffee.price)원")
                            .font(.title)
                            .bold()
                        
                        Image(.icedhot)
                    }
                    
                    .padding()
                    
                    Spacer()
                    
                    
                    
                    /*if coffee.availableType.count > 1 {
                        HStack {
                            ForEach(coffee.availableType, id: \.self) { type in
                                Button(action: {
                                    withAnimation {
                                        selectedType = type
                                    }
                                }) {
                                    Text(type.rawValue)
                                        .background(selectedType == type ? Color.blue : Color.grey00)
                                        .frame(width: 100)
                                        .foregroundColor(.white1)
                                }
                            }
                        } //hstack */
                    } //if
                        
                    
                        
                }
                
            
            
            Button(action: {
                print("주문하기")
            }) {
                Image(.orderButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 383, height: 43)
            }
            .navigationBarBackButtonHidden(true)
            
        }
        
        
    

        //vstack
    }//var body
//struct

#Preview {
    CoffeeInfoView(coffee: Coffee(
        name: "에스프레소 마끼아또", englishName: "Espresso Macchiato", description: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: 3900, image: "EspressoMacchiato", availableType: [.iced]
    ))
}
