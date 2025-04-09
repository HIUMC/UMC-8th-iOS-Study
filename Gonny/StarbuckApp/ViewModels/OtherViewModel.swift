//
//  OtherViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/31/25.
//
import SwiftUI
import Observation

class OtherViewModel: ObservableObject {
    @AppStorage("nickname") var savednickname: String = "사용자"

    
    func buttonTapped(_ title: String) {
        print("\(title) 버튼이 눌렸습니다.")
    }
}
