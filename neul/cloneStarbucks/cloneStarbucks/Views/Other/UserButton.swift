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
    private var action: () -> Void
    
    init(image: String, title: String, action: @escaping () -> Void) {
        self.image = image
        self.title = title
        self.action = action
    }
    
    
    var body: some View {
        Button(action: {
            action()
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


