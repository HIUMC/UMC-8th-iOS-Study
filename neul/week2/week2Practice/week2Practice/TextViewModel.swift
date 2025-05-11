//
//  TextViewModel.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

class TextViewModel: ObservableObject {
    @Published var inputText: String = ""
    
    init() {
        print("새로운 textviewmodel 인스턴스 생성됨")
    }
}
