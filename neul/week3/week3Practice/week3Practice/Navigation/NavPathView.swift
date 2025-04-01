//
//  NavPathView.swift
//  week3Practice
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct NavPathView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("go to detail") {
                    path.append("detail")
                }
            }
            // 이 밑의 얘네들은 VStack에다 적용하는 거임.
            /*
             NavigationStack는 책, VStack은 그 책의 내용,
             navigationTitle, navigationDestination 같은 modifier들은 그 책의 제목과 이동규칙
             NavigationStack 안의 최상위 뷰에 Modifier 붙이기
             */
            
            //특정 타입의 데이터(예: String)을 기준으로 화면 정의 가능
            .navigationDestination(for: String.self) { value in
                DetailView(title: value)
            }
            .navigationTitle("Home")
        }
    }
}

fileprivate struct DetailView: View {
    //시스템이 제공하는 Dismiss 기능을 environment에서 꺼내쓰는거
    @Environment(\.dismiss) var dismiss
    let title: String
    var body: some View {
        Text("This is \(title) View")
            .navigationTitle(title)
        Button("아~ 뒤로가기") {
            dismiss()
        }
    }
}

#Preview {
    NavPathView()
}
