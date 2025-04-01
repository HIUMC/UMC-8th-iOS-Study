//
//  CustomNavBackButton.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//
import SwiftUI

struct CustomNavBackButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button{
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left") // 화살표 Image
                    .aspectRatio(contentMode: .fit)
                    .tint(.black)
            }
        }
    }
}
