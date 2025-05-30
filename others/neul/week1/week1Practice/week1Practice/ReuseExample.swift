//
//  ReuseExample.swift
//  week1Practice
//
//  Created by tokkislove on 3/22/25.
//

import SwiftUI

struct ReuseExample: View {
    var body: some View {
        /*VStack {
            headerView
            messageView
            actionButton
        }*/
        VStack {
            HeaderView(text: "헤더입니다.")
            MessageView(message: "메시지입니다")
        }
    }
    
    private var headerView: some View {
        Text("hello swiftUI")
            .font(.title)
            .foregroundStyle(Color.red)
    }
    
    private var messageView: some View {
        Text("이제 하위 뷰를 만들어보자")
            .font(.title)
            .foregroundStyle(Color.gray)
    }
    
    private var actionButton: some View {
        Button(action: {
            print("버튼 눌렸네요 ㅎㅎ")
        }, label: {
            Text("클릭해보세요!")
        })
    }

}



/* HeaderView */
struct HeaderView: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    var body: some View {
        Text(text)
            .foregroundStyle(Color.red)
            .font(.largeTitle)
    }
}

/* MessageView */
struct MessageView: View {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        Text(message)
            .font(.title)
            .foregroundStyle(Color.green)
    }
}


#Preview {
    ReuseExample()
}
