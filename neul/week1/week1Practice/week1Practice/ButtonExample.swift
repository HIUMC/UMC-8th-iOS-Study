//
//  ButtonExample.swift
//  week1Practice
//
//  Created by tokkislove on 3/20/25.
//

import SwiftUI

struct ButtonExample: View {
    var body: some View {
        Button("나를 클릭해보세요!") {
            print("하하하하호호호호")
        }
        Spacer(minLength: 30)
        //커스텀용
        Button(action: {
            print("버튼. 눌렸다.")
        }) {
            Text("클릭하셈~")
                .padding()
                .background(Color.pink)
                .foregroundColor(Color.black)
                .cornerRadius(10)
                .font(.title)
        }
        

        // 이런 것도 됨(voiceover용)
        Button("Sign In", systemImage: "arrow.up", action: signIn)
            .labelStyle(.iconOnly)

    }
    
    func signIn() {
        print("signin")
    }
}

#Preview {
    ButtonExample()
}
