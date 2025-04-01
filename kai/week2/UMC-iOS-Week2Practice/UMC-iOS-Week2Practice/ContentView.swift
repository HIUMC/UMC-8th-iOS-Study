//
//  ContentView.swift
//  UMC-iOS-Week2Practice
//
//  Created by 김지우 on 3/23/25.
//

import SwiftUI

/*struct ContentView: View{
    @State private var count = 0 // 상태 프로퍼티 선언
    
    var body: some View{
        VStack{
            Text("카운트: \(count)") // 값이 변경되면 자동으로 업데이트
                .font(.largeTitle)
            
                .padding()
            
            Button("증가"){
                count += 1//상태 변경 시 자동으로 업데이트 된다!!
            }
            
            Button("감소"){
                count -= 1
            }
            .padding()
            }
        }
    }

 */

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View{
        VStack{
            Text("텍스트 내용:\(text)")
                .font(.largeTitle)
                 
                 TextField("아무 값을 입력해보세요!",text:$text)
                .frame(width:350)
        }
    }
}
#Preview {
    ContentView()
}


