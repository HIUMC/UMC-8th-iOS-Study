//
//  UserButton.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/31/25.
//
import SwiftUI

struct UserButton: View {
    private var image: String
    private var title: String
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }
    
    
    var body: some View {
        Button(action: {
            print("userButton: \(title) 버튼 눌림")
        }, label: {
            VStack(spacing: 4) {
                Image(image)
                    .resizable()
                    .frame(width: 48, height: 48)
                Text(title)
                    .foregroundStyle(Color.black03)
                    .font(.MainTextSemiBold16)
            }
            .frame(width: 102, height: 108)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 0)
            
        })
    }
}

#Preview {
    UserButton(image: "starHistory", title: "별 히스토리")
}
