//
//  CustomBackButton.swift
//  Starbucks
//
//  Created by 박정환 on 4/9/25.
//

import SwiftUI

struct CustomBackButton: View {
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
