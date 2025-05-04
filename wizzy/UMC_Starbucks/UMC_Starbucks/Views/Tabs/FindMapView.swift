//
//  FindMapView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/4/25.
//

import SwiftUI

struct FindMapView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            // 왼쪽 버튼 (이전)
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.black)
            }
            
            Spacer()
        }
    }
}

#Preview {
    FindMapView()
}
