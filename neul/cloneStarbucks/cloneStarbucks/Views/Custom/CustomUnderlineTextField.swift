//
//  CustomUnderlineTextField.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/29/25.
//
import SwiftUI

struct CustomUnderlineTextField: View {
    var placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
            VStack(alignment: .leading) {
                TextField(placeholder, text: $text)
                        .focused($isFocused)
                
                Divider()
                    .frame(height: 0.7)
                    .overlay(isFocused ?  .green01: .gray00)
            }
        }
}
