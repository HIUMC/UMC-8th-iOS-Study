//
//  AdvertisementView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/26/25.
//

import SwiftUI

struct AdvertisementView: View {
    
    @State private var showAdvertisementSheet = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Image("Advertisement")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            Spacer()
            
            VStack{
                Button(action: {
                    print("자세히 보기")
                }) {
                    HStack {
                        Spacer()
                        Text("자세히 보기")
                            .foregroundStyle(.white)
                            .font(.customPretend(.medium, size: 18))
                        Spacer()
                    }
                    .frame(height: 58)
                    .background(Color.mainGreen)
                    .cornerRadius(20)
                }
                .padding(.bottom, 19)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("X 닫기")
                            .foregroundStyle(Color.advertisementColor)
                            .font(.customPretend(.light, size: 14))
                    })
                }
            }
            .padding(.horizontal, 18)
        }
    }
}

#Preview {
    AdvertisementView()
}
