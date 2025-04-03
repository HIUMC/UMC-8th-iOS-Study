
//
//  AddView.swift
//  Starbucks
//
//  Created by 이가원 on 3/28/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Image(.addimage)
            Spacer()
            bottomView
        }
        .frame(height:920)
        .padding()
        .ignoresSafeArea()
    }
    

    private var bottomView: some View {
        VStack(spacing: 19) {
            Button(action: {
                print("자세히 보기")
            }) {
                Text("자세히 보기")
                    .font(.custom("Pretendard-Medium", size: 18))
                    .foregroundColor(.white)
                    .frame(width: 402, height: 58)
                    .background(Color("green1"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            HStack {
                Spacer().frame(width:350)
                Button(action: {
                                dismiss()
                            }) {
                                Text("X 닫기")
                                    .font(.custom("Pretendard-Medium", size: 14))
                                    .foregroundStyle(.gray5)
                            }
                            .padding(.trailing, 8)
                        }
        }
        .frame(width:402, height:94)
        .padding()
    }
}

#Preview {
    AddView()
}
