//
//  PopupView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI

struct PopupView: View {
    @State private var showSheet = false
    
    var body: some View {
        
        VStack{
            //.frame(maxWidth: .infinity, maxHeight: 720)
            Image("PopupImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 438, height: 720)
                .clipped() //?
            
            Spacer()
            
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
            
            
            
        } //v
        
        .padding(.horizontal, 19) //?
    }
    
}
/*
struct SheetContents: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button("back") {
            dismiss()
        }
    }
}
 */



#Preview {
    PopupView()
}
