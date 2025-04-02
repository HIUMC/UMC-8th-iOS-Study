//
//  CustomButton.swift
//  UMC-iOS-WorkBook
//
//  Created by 곽은채 on 3/25/25.
//

import SwiftUI

struct CustomButton: View {
    
    @Binding var isClicked: Int
    
    init(isClicked: Binding<Int>) {
        self._isClicked = isClicked
    }
    
    var body: some View {
        Button(action: {
            isClicked += 1
            print("하위 뷰에서 클릭해서 값 변경함 : \(isClicked)")
        }, label: {
            Text("상위 뷰의 값을 State 값 증가")
        })
    }
}
