//
//  FindMapView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/4/25.
//

import SwiftUI

struct FindMapView: View {
    

    var body: some View {
        VStack(spacing: 0) {
            TopFindBar()
            MiddleFindBar()
                .padding(.bottom, 10)
            MapView()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}


struct TopFindBar: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.black)
            }

            Spacer()
            Text("매장 찾기")
                .font(.PretendardMedium16)
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)

    }
}

struct MiddleFindBar: View {
    @State private var selectedTab: Int = 0
    @Namespace private var underlineAnimation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<2) { index in
                let title = index == 0 ? "매장 찾기" : "길찾기"
                Button(action: {
                    withAnimation(.easeInOut) {
                        selectedTab = index
                    }
                }) {
                    Text(title)
                        .font(.PretendardSemiBold24)
                        .foregroundStyle(.black)
                        .padding(.bottom, 10)
                        .overlay(
                            ZStack {
                                if selectedTab == index {
                                    Capsule()
                                        .fill(Color.brown)
                                        .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                                        .frame(width: 110, height: 4)
                                        .offset(y: 14)
                                }
                            }
                        )
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 10)
        .background(Color.white)
    }
}



#Preview {
    FindMapView()
}
