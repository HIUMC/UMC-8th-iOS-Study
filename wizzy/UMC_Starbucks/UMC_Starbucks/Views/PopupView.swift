//
//  PopupView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI

struct PopupView: View {
    @State private var showSheet = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                //.frame(maxWidth: .infinity, maxHeight: 720)
                Image("PopupImage")
                    .resizable()
                //.padding(.bottom, 106)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 720)
                    .ignoresSafeArea()
                //.padding(.bottom, 40)
                //Spacer().frame(height: 100)
                
                //Spacer()
                detailButton
                //Spacer()
                closeButton
                //Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            
        } //v
        .ignoresSafeArea()
        
    }
    
    
    
    private var detailButton: some View {
        
        Button(action: {
            print("자세히 보기")
        }) {
            Text("자세히 보기")
                .font(.PretendardMedium16)
                .frame(width: 402, height: 58)
                .background(Color.loginButtonGreen)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: {
                print("닫기")
                dismiss()
                
            }) {
                Text("X 닫기")
                    .font(.PretendardLight14)
                    .foregroundStyle(Color.popupGray)
            }
            .padding(.trailing, 19)
        } // h
    }
    

} // struct


#Preview {
    PopupView()
}

