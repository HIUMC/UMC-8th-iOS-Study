//
//  CustomNavigationView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//

import SwiftUI

struct CustomNavigationView: View {
    var title: String
    @Environment(\.dismiss) private var dismiss // 환경 변수 추가 (네비게이션 POP을 위해)

    var body: some View {
        HStack {
            
            // 뒤로 가기 버튼
            Button(action: {
                dismiss() // 현재 화면 닫기 (네비게이션 POP)
            }) {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.black)
            }

            Spacer()

            // 중앙 타이틀
            Text(title)
                .font(.PretendardMedium16)
                .foregroundColor(.black)

            Spacer()

            // 오른쪽 공백 맞추기용 (투명 버튼)
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.clear) // 투명하게 해서 간격 유지
            }
        }
  
        .padding()
        .background(Color.white)
    }
}


#Preview {
    CustomNavigationView(title: "title")
}

//어차피 상단에 넣을 것이기 때문에....굳이 여기서 뭐 위로 보내고 조정 할 필요는 없 다 ..... 상단 뷰로 불러오면 되기 때문에...
