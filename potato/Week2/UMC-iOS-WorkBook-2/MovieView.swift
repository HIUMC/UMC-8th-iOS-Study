//
//  MovieView.swift
//  UMC-iOS-WorkBook-2
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI
import Observation

struct MovieView: View {
    @AppStorage("movieName") private var movieName: String = ""
    private var movieViewModel: MovieViewModel = .init()
    
    var body: some View {
        VStack(spacing: 56) {
            MovieCard(movieInfo: movieViewModel.movieModel[movieViewModel.currentIndex])
            
            movieChange
            
            settingMovie
            
            printAppStorage
        }
        .padding()
    }
    
    private var movieChange: some View {
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
        .frame(width: 256)
        .padding(.vertical, 17)
        .padding(.horizontal, 22)
    }
    
    private var settingMovie: some View {
        Button(action: {
            self.movieName = movieViewModel.movieModel[movieViewModel.currentIndex].movieName
        }, label: {
            Text("대표 영화로 설정")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(Color.black)
                .padding(.top, 21)
                .padding(.bottom, 20)
                .padding(.leading, 53)
                .padding(.trailing, 52)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                        .stroke(Color.black, style: .init(lineWidth: 1))
                })
        })
    }
    
    private var printAppStorage: some View {
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

#Preview {
    MovieView()
}
