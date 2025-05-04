
//
//  Adpop.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/30/25.
//

import SwiftUI

struct AdPopupView: View {
    @Environment(\.dismiss) private var dismiss //  닫기 버튼에 사용!
    var onClose: () -> Void
    
    var body: some View {
        VStack {
            Image("advertisement")
                .resizable()
                .aspectRatio(contentMode: .fill) //프레임을 꽉 채움
                .frame(maxWidth: .infinity, maxHeight: 720)
                .edgesIgnoringSafeArea(.top)
               // .frame(width:438, height:702)
            
            //버튼
            
            VStack {
            
                // 자세히 보기 버튼
                Button(action: {
                    print("자세히 보기")})
                {
                    
                    Text("자세히 보기")
                        .font(.mainTextMedium18)
                        .foregroundColor(Color("white01"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 18.5)
                    
                }
                .frame(width: 380, height: 58)
                .background(Color("green01"))
                .cornerRadius(20)
                
                Spacer()
                
                HStack{
    
                    Spacer()
                    // 닫기 버튼
                    Button("X 닫기") {
                        dismiss()
                        
                    }
                    .font(.mainTextLight14)
                    .foregroundColor(Color("gray03"))
                    .padding(.horizontal,18)
                }
            }
            
            .padding(.bottom, 36) // 이미지 아래 간격
           
        }
    }
}
    



#Preview {
    AdPopupView(onClose: {})
}
