//
//  ReceiptView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/7/25.
//

import SwiftUI

struct ReceiptView: View {
    @Environment(\.dismiss) var dismiss
    // @Binding var showActionSheet: Bool
    // 바인딩 가져오면 파라미터는 어떻게 처리?
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                VStack(alignment: .leading) { //v3
                    
                    Rectangle()
                        .frame(height: 0.7)
                        .foregroundStyle(Color.signupGray)
                        .padding(.bottom, 47)
                    
                    Rectangle()
                        .frame(height: 0.7)
                        .foregroundStyle(Color.signupGray)
                        .padding(.bottom, 47)
                    
                    Rectangle()
                        .frame(height: 0.7)
                        .foregroundStyle(Color.signupGray)
                        .padding(.bottom, 47)
                    
                    
                } // v3
                Spacer()
            } //VStack
            
            .padding(.horizontal, 19) // 양옆
            .navigationBarBackButtonHidden(true) // 기본 뒤로가기 버튼 숨기기
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.black)
                    }
                } // <
                
                ToolbarItem(placement: .principal) { // .center가 없다!
                    Text("전자영수증")
                        .font(.PretendardMedium16)
                        .foregroundStyle(Color.black00)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.black)
                    }
                }
            }
            
        }
    }
}
        
        /*
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        } //v
        navigationBarBackButtonHidden(true) // 기본 뒤로가기 버튼 숨기기
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                }
            } // <
            
            ToolbarItem(placement: .principal) { // .center가 없다!
                Text("전자영수증")
                    .font(.PretendardMedium16)
                    .foregroundStyle(Color.black00)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                }
            }
        } //toolBar
    }
}
         
         */


#Preview {
    NavigationStack {
        ReceiptView()
    }
}
 
/*
 #Preview {
 NavigationStack {
 VStack {
 Text("Preview Test")
 }
 .navigationBarBackButtonHidden(true)
 .toolbar {
 ToolbarItem(placement: .topBarLeading) {
 Button("뒤로") { }
 }
 ToolbarItem(placement: .principal) {
 Text("타이틀")
 }
 ToolbarItem(placement: .topBarTrailing) {
 Button("닫기") { }
 }
 }
 }
 }
 */
