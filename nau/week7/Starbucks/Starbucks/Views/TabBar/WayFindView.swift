//
//  WayFindView.swift
//  Starbucks
//
//  Created by nau on 5/20/25.
//

import SwiftUI

struct WayFindView: View {
    
    @State private var start: String = ""
    @State private var end: String = ""
    
    @Environment(NavigationRouter.self) var router
    
    @State var viewModel: WayFindViewModel = .init()
  
    @State private var address = ""
    
    var body: some View {
        VStack(spacing: 28) {
            
            Divider()
            
            topView
            
            Spacer()
            
        }
    }
    
    private var topView: some View {
        VStack {
            HStack {
                Text("출발")
                    .font(.mainTextSemibold16)
                
                Button(action: {
                    start = viewModel.address
                }, label: {
                    Text("현재위치")
                        .font(.mainTextSemibold13)
                        .foregroundStyle(.white01)
                        .frame(width: 58, height: 30)
                        .background(Color.brown00)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                
                TextField("출발지 입력", text: $start)
                    .padding(EdgeInsets(top: 7, leading: 9, bottom: 7, trailing: 9))
                    .border(.gray01, width: 1)
                    .font(.mainTextRegular13)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                })
            }
            
            HStack {
                Text("도착")
                    .font(.mainTextSemibold16)
                
                TextField("매장명 또는 주소", text: $end)
                    .padding(EdgeInsets(top: 7, leading: 9, bottom: 7, trailing: 9))
                    .border(.gray01, width: 1)
                    .font(.mainTextRegular13)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                })
            }
            
            Button(action: {
                
            }, label: {
                Text("경로 찾기")
                    .font(.mainTextMedium16)
            })
            .buttonStyle(mainBtnStyle())
            .frame(maxHeight: 38)
            
            Spacer()
        }.padding(.horizontal, 31)
    }
}

#Preview {
    WayFindView()
}
