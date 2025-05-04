//
//  JSONParsingView.swift
//  Practice5
//
//  Created by 신민정 on 4/26/25.
//


import SwiftUI

struct JSONParsingView: View {
    
    var viewModel: JSONParsingViewModel = .init()
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.loadMyProfile { result in
                    switch result {
                    case .success(_):
                        self.showSheet.toggle()
                    case .failure(let error):
                        print("error: \(error)")
                    }
                }
            }, label: {
                Text("json 파일 파싱하기 버튼")
                    .font(.headline)
                    .foregroundStyle(Color.red)
            })
            .sheet(isPresented: $showSheet, content: {
                VStack {
                        if let profile = viewModel.myProfile {
                            Text("닉네임: \(profile.nickname)")
                            Text("취미: \(profile.hobby)")
                            Text("좋아하는 캐릭터: \(profile.favoriteCharacter)")
                            Text("거주지: \(profile.location)")
                        }
                    }
                .presentationDragIndicator(.visible)
            })
            .presentationDetents([.medium, .large])
            
            Spacer()
        }
    }
}

#Preview {
    JSONParsingView()
}
