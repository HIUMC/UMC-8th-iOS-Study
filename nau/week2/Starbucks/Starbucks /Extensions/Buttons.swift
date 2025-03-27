//
//  Button.swift
//  Starbucks
//
//  Created by nau on 3/26/25.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
                print("")
            }, label: {
                Text("")
            }).buttonStyle(mainBtnStyle())
            
            Button(action: {
                print("")
            }, label: {
                Text("")
            }).buttonStyle(otherTopBtnStyle())
        }
    }
}

//버튼스타일을 만들어 적용..
struct mainBtnStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.green01))
                .frame(maxHeight: 60)
            
            configuration.label
                .font(.makeMedium18)
                .foregroundColor(.white)
        }
    }
}

struct otherTopBtnStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.white))
                .shadow(color: Color(white: 0, opacity: 0.1), radius: 5)
                .frame(maxWidth: 102, maxHeight: 108)
            
            configuration.label
                .font(.mainTextSemibold16)
                .foregroundColor(Color(.black03))
    
        }
    }
}

#Preview {
    Buttons()
}
