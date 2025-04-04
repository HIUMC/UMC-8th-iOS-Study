//
//  CoffeeView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import SwiftUI

struct CoffeeView: View {
    let coffee: CoffeeModel
    @State var isIce: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        VStack(alignment: .leading) { //v1
            Image(coffee.imageD)
                .padding(.bottom, 20)
            CoffeeTitleInfo
            CoffeeMidInfo
        } //v1
        .ignoresSafeArea(edges: .top)
        .padding(.horizontal, 10)
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("leftIcon")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image("shareIcon")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }
        }
        
        
        HotNColdButton
        Spacer()
        OrderButton
        
        
    }//body
    
    
    
    
    private var CoffeeTitleInfo: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(coffee.title)
                    .font(.PretendardSemiBold24)
                    .foregroundStyle(Color.black03)
                
                Image("new")
                    .frame(width: 14, height: 6.5)
            }//h
            Text(coffee.engTitle)
                .font(.PretendardSemiBold14)
                .foregroundStyle(Color.loginGray)
                .padding(.top, 4)
            
        }
        .padding(.horizontal, 10)
    }
    
    
    
    private var CoffeeMidInfo: some View {
        
        VStack (alignment: .leading) {
            Text(coffee.content)
                .font(.PretendardSemiBold14)
                .foregroundStyle(Color.gray66)
            
                .padding(.top, 32)
            Text("\(coffee.price)원")
                .font(.PretendardBold24)
                .foregroundStyle(Color.black03)
                .padding(.top, 20)
            //.padding(.bottom, 32)
            
            
        } //v
        .padding(.horizontal, 10)
        
    }
    
    /*
     private var HotNColdButton: some View {
     ZStack {
     HStack {
     Spacer()
     RoundedRectangle(cornerRadius: 999)
     .stroke(Color.gray.opacity(0.4), lineWidth: 1)
     .fill(Color.white)
     .frame(width: 420, height: 36)
     
     
     
     .overlay(
     Text("\(coffee.choice) ONLY")
     .font(.PretendardBold15)
     .foregroundStyle(Color.red01)
     .opacity(0.63)
     )
     Spacer()
     }
     
     
     }//z
     
     }
     */
    
    private var HotNColdButton: some View {
        ZStack {
            HStack {
                
                if coffee.choice == .both {
                    bothChoice
                }
                else {
                    RoundedRectangle(cornerRadius: 999)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        .fill(Color.white)
                        .frame(width: 420, height: 36)
                        .overlay {
                            Text("\(coffee.choice) ONLY")
                            font(.PretendardBold15)
                                .foregroundStyle(coffee.choice.color)
                            
                        }
                    
                }
                
                
                
            }// h
        } // z
    }
    
    
    var bothChoice: some View {
        GeometryReader { geometry in
            ZStack (alignment: isIce == false ? .leading : .trailing) { //z
                RoundedRectangle(cornerRadius: 999)
                    .fill(Color.gray07)
                    .frame(height: 36)
                    
                
                RoundedRectangle(cornerRadius: 999)
                    .fill(Color.white)
                    .frame(width: geometry.size.width*0.5)
                    .frame(height: 36)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 1)
                
                HStack {
                    
                    Text("HOT")
                        .font(.PretendardSemiBold18)
                        .frame(maxWidth:.infinity) //가능한 모든 너비를 차지하겠다고 선언
                            //SwiftUI의 기본 텍스트 정렬은 가운데(center)
                        .foregroundStyle(isIce == false ? .red01 : .signupGray)
                        .onTapGesture {
                            withAnimation {
                                isIce = false
                            }
                        }
                    
                    Text("COLD")
                        .font(.PretendardSemiBold18)
                        .frame(maxWidth:.infinity)
                        .frame(height: 36)
                        .foregroundStyle(isIce == true ? .blue01 : .signupGray)
                        .onTapGesture {
                            withAnimation {
                                isIce = true
                            }
                        }
                    
                }.padding(.horizontal, 10)
            }
            .padding(.horizontal, 10)
        }
    }
}


    
    private var OrderButton: some View {
        Button {
            print("주문하기")
        } label: {
            RoundedRectangle(cornerRadius: 999)
                .fill(Color.green00)
                .frame(width: 383, height: 43)
                .overlay(
                    Text("주문하기")
                        .font(.PretendardMedium16)
                        .foregroundStyle(Color.white)
                )
        }
        .padding(.bottom, 29)

        

    
    
}//struct


/*
#Preview {
    CoffeeView(coffee: .init(title: "에스프레소 마끼야또", engTitle: "Espresso Macchiato", content: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: "3,900", choice: .iced, image: "espressoMacchiato",imageD: "macchiato"))
}
*/

#Preview {
    CoffeeView(coffee: CoffeeModel(
        title: "Test Coffee",
        engTitle: "Test Coffee ENG",
        content: "테스트용 커피 설명입니다.",
        price: "4,200",
        choice: .both,
        image: "cup.and.saucer.fill",   // ✅ SFSymbol 이름
        imageD: "cup.and.saucer.fill"
    ))
}
