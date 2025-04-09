//
//  AdView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI

struct AdView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
            Image(.ad)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 720)
            Spacer()
            bottom
        }
        .padding(.top, 0)
        .padding(.bottom, 36)
        .ignoresSafeArea()
    }
    
    private var bottom: some View {
        VStack(alignment: . trailing, spacing: 19) {
            Button(action: {
                print("자세히 보기")
            }, label: {
                Text("자세히 보기")
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color("white01"))
                    .frame(maxWidth: .infinity, maxHeight: 58)
                    .background() {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("green01"))
                            .frame(height: 58)
                    }
            })
            Button(action: {
                dismiss()
            }, label: {
                Text("X 닫기")
                    .font(.mainTextLight14)
                    .foregroundStyle(Color("gray05"))
            })
        }
        .padding(.horizontal, 18)
    }
}

#Preview {
    AdView()
}
