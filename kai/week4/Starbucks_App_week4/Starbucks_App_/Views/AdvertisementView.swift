//
//  AdvertisementView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import SwiftUI

struct AdvertisementView: View {
    @Binding var showAd: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image(.advertisement)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            Spacer().frame(height: 30)
            
            VStack {
                Button(action: {
                    print("자세히 보기")
                }) {
                    Image(.lookCloser)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 58) // 버튼 크기 조정
                }
                
                Spacer().frame(height: 10) // 버튼과 닫기 사이 간격 조정
                
                HStack {
                    Spacer() // 닫기 버튼을 오른쪽으로 정렬
                    Button(action:{
                        dismiss()
                    }){
                        Text("X 닫기")
                            .font(.PretendardRegular13)
                            .foregroundStyle(Color.gray)
                        Spacer().frame(width:30)
                    }//닫기버튼_end
                }//HStack_end
            }//자세히보기VStack_end
        }//전체VStack_end
    }//someView_end
}

#Preview {
    AdvertisementView(showAd: .constant(true))
}
