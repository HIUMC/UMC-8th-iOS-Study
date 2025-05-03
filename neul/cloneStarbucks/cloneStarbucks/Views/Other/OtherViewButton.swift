//
//  OtherViewButton.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/31/25.
//
import SwiftUI

struct OtherViewButton: View {
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
            HStack(spacing: 5) {
                Image(image)
                    .resizable()
                    .frame(width: 32, height: 32)
                Text(title)
                    .foregroundStyle(Color.black02)
                    .font(.MainTextSemiBold16)
            }
            
        })
    }
}


