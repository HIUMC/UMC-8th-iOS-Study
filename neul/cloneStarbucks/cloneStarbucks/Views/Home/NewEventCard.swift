//
//  NewEventCard.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//

import SwiftUI


struct NewEventCard: View {
    private var imageName: String
    private var title: String
    private var content: String
    
    init(imageName: String, title: String, content: String) {
        self.imageName = imageName
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(imageName)
                .frame(width: 242, height: 160)
            Text(title)
                .font(.MainTextSemiBold18)
                .foregroundStyle(.black02)
            Text(content)
                .font(.MainTextSemiBold13)
                .foregroundStyle(.gray03)
        }
    }
}
