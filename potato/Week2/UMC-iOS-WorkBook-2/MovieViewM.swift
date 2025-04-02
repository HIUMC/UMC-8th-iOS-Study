//
//  MovieView.swift
//  UMC-iOS-WorkBook-2
//
//  Created by 곽은채 on 3/28/25.
//

import SwiftUI

struct MovieViewM: View {
    var movieViewModel: MovieViewModel = .init()
    @AppStorage("movieName") private var movieName: String = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 61) {
                Button(action: {
                    movieViewModel.previousMovie()
                }, label: {
                    Image(systemName: "chevron.left")
                })
                .foregroundStyle(Color.black)
                
                Text("영화 바꾸기")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(Color.black)
                
                Button(action: {
                    movieViewModel.nextMovie()
                }, label: {
                    Image(systemName: "chevron.right")
                })
                .foregroundStyle(Color.black)
            }
            .padding(.vertical, 17)
            .padding(.horizontal, 22)
            
            
            Button(action: {
                movieName = movieViewModel.movieModel[movieViewModel.currentIndex].movieName
            }, label: {
                Text("대표 영화로 설정")
                    .padding()
            })
            
            VStack(spacing: 17) {
                Text("@AppStorage에 저장된 영화")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundStyle(Color.black)
                
                Text("현재 저장된 영화: \(movieName)")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(Color.red)
            }
        }
    }
}

#Preview {
    MovieViewM()
}
