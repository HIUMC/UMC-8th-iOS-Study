//
//  CustomNav.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import SwiftUI

struct CustomNav: View {
    let title: String
    let navImage: String?
    @Environment(\.dismiss) private var dismiss
    
    init(title: String, navImage: String? = nil) {
        self.title = title
        self.navImage = navImage
    }
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .aspectRatio(contentMode: .fit)
                        .tint(.black)
                }
            }
            Spacer()

            Text(title)
                .font(.mainTextMedium16)

            Spacer()

            if let imageName = navImage {
                Image(imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
            } else {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 24, height: 24)
            }
        }
        .padding()
    }
}
