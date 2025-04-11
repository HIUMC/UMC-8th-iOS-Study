//
//  NavBarView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/10/25.
//

import SwiftUI

struct NavBarView: View {
    var dismiss: () -> Void
    var plusButtonTapped: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 50.0)
                .foregroundStyle(Color.white)
            HStack {
                // 왼쪽 버튼 (이전)
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                }
                
                Spacer()
                
                // 가운데 텍스트
                Text("전자영수증")
                    .font(.PretendardMedium16)
                    .foregroundStyle(Color.black00)
                
                Spacer()
                
                // 오른쪽 버튼 (+)
                Button(action: {
                    plusButtonTapped()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 50.0) // 이거 바 길이 조절 어떻게 해야 되는 건지....
            //.frame(height: 60)
            //.frame(, height: 60)
            //.frame(maxWidth: .infinity, height: 60)
            //.padding(.horizontal)
            //.padding(.top, 10) // 필요 시 여백 조절
        }
        //.frame(maxWidth: .infinity, height: 60)
    }
}

