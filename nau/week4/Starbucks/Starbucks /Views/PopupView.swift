//
//  PopupView.swift
//  Starbucks
//
//  Created by nau on 3/25/25.
//

import SwiftUI

struct PopupView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(NavigationRouter.self) private var router
    
    @Binding var showPopup : Bool
 
    var body: some View {
        VStack {
            imageView
                .ignoresSafeArea()//이걸 할지 말지 고민... 일단 함
            
            Spacer()
            
            bottomView
        }.navigationBarBackButtonHidden(true)
    }
    
    private var imageView: some View {
        Image(.popup)
            .resizable()
            .scaledToFit()
    }
    
    private var bottomView: some View {
        VStack(alignment: .trailing, spacing: 19) {
            Button(action: {
                print("자세히 보기")
            }, label: {
                Text("자세히 보기")
            }).buttonStyle(mainBtnStyle())
            
            //하단 x 닫기 버튼
            Button(action: {
                showPopup = false
            }, label: {
                Text("X 닫기")
                    .font(.mainTextLight14)
                    .foregroundStyle(Color(.gray05))
                    .padding(.trailing, 15)
            })
        }.padding(.horizontal, 18)
    }
}

/*
#Preview {
    @Previewable var showPopup = true
    
    PopupView(showPopup: true)
}
*/
