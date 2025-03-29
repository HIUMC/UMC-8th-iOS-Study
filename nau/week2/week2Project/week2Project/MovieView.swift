//
//  MovieView.swift
//  week2Project
//
//  Created by nau on 3/20/25.
//

import SwiftUI

struct MovieView: View {
    
    @AppStorage("movieName") private var movieName: String = ""
    private var viewModel: MovieViewModel = .init()
    
    var body: some View {
        
        VStack(spacing: 56){
       
            MovieCard(movieInfo: viewModel.movieModel[viewModel.currentIndex])
   
            changeMovie
     
            movieChoice
  
            bottomTextStack
        }
    }
    
    private var changeMovie: some View {
        HStack(spacing: 61) {
            Button(action: {
                viewModel.previousMovie()
            }, label: {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(Color.black)
            })
            Text("영화 바꾸기")
                .font(.system(size: 20, weight: .regular))
            Button(action: {
                viewModel.nextMovie()
            }, label: {
                Image(systemName: "chevron.forward")
                    .foregroundStyle(Color.black)
            })
        }
    }
    
    private var movieChoice: some View {
        Button(action: {
            //@AppStorage에 movieName 저장
            self.movieName = viewModel.movieModel[viewModel.currentIndex].movieName
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 1)
                    .background(Color.clear)
                    .frame(width: 246, height: 65)
                Text("대표 영화로 설정")
            }.foregroundStyle(Color.black)
        })
    }
    
    private var bottomTextStack: some View {
        VStack(spacing: 17) {
            Text("@AppStorage에 저장된 영화")
            Text("현재 저장된 영화 \(movieName)")
                .foregroundStyle(Color.red)
        }
    }
}

#Preview {
    MovieView()
}
