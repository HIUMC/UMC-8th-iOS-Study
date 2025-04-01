//
//  Advertisementview.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/26/25.
//

import SwiftUI

struct Advertisementview: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(alignment: .trailing){
            
            Image(.advertisement)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            Spacer()
            
            Button(action: {
                print("자세히 보기")
            }) {
                Image(.lookcloser)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 18)
            }
            
            Button(action: {
                dismiss()
            }) {
                
                Text("X 닫기")
                    .font(.mainTextRegular14)
                    .foregroundColor(.grey05)
                    .frame(alignment: .trailing)
                    .padding(.trailing, 23)
            }

        }
    }
}


#Preview {
    Advertisementview()
}
