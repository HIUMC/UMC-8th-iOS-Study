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
        VStack(alignment: .leading, spacing: 16) {
            Image(imageName)
                .frame(width: 242, height: 160)
            Text(title)
                .font(.MainTextSemiBold18)
                .foregroundStyle(.black02)
                .lineLimit(1)
            Text(content)
                .font(.MainTextSemiBold13)
                .foregroundStyle(.gray03)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .frame(width: 242, height: 250)
    }
}

#Preview {
    let viewModel = NewEventViewModel()
    NewEventCard(imageName: viewModel.newEvents[2].imageName, title: viewModel.newEvents[2].title, content: viewModel.newEvents[2].content)
}
