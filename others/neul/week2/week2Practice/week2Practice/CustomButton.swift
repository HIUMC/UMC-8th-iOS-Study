//
//  CustomButton.swift
//  week2Practice
//
//  Created by tokkislove on 3/25/25.
//

import SwiftUI

struct CustomButton: View {
    
    @Binding var isClicked: Bool
    
    init(isClicked: Binding<Bool>) {
        self._isClicked = isClicked
    }
    
    var body: some View {
        Button(action: {
            isClicked.toggle()
            print("하위 뷰(버튼)에서 클릭해서 값 변경 : \(isClicked)")
        } , label: {
            Text("상위 뷰의 state 값 변경")
        })
    }
}

