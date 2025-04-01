//
//  MovieView.swift
//  week2Lab
//
//  Created by tokkislove on 3/29/25.
//

import SwiftUI

struct MovieView: View {
    @AppStorage("movieName") private var movieName: String = "미키"
    private var viewModel: MovieViewModel = .init()
    
    var body: some View {
        VStack {
            MovieCard(movieInfo: viewModel.movieModel[viewModel.currentIndex])
            Spacer()
            changeMovieView
            Spacer()
            makeTitleView
            Spacer()
            appStorageView
        }
        .padding(.horizontal, 20)
        .frame(height: 594)
        
    }
    
    private var changeMovieView: some View {
        HStack(spacing: 61) {
            Button(action: {
                viewModel.previousMovie()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundStyle(.black)
            }
            Text("영화 바꾸기")
                .font(.system(size: 25, weight: .regular))
            Button(action: {
                viewModel.nextMovie()
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 17)
    }
    
    /*/// 화살표 재사용하기 위한 하위 뷰
     /// - Parameters:
     ///   - name: 이미지 이름 설정
     ///   - action: 버튼이 가지는 액션 기능 넣기, @escaping은 추후 문법을 통해 배우게 될 겁니다!
     /// - Returns: some View 타입 반환
     private func makeChevron(name: String, action: @escaping () -> Void) -> some View {
         Button(action: {
             action()
         }, label: {
             Image(systemName: name)
                 .resizable()
                 .frame(width: 17.47, height: 29.73)
         })
     }*/
    
    /* 다른 방식으로 구현 -
     ZStack으로 RoundedRectangle을 만들고 위에 Text() 얹이기
    또는, Text()만 만들고 패딩으로 상하좌우 여백을 늘려서 stroke 주기 → DevMode로 확인*/
    private var makeTitleView: some View {
        Button(action: {
            movieName = viewModel.movieModel[viewModel.currentIndex].movieName
        }) {
            Text("대표 영화로 설정")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.black)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                        .stroke(Color.black, style: .init(lineWidth: 1))
                        .frame(width: 246, height: 65)
                }
        }
    }
    
    private var appStorageView: some View {
        VStack(spacing: 17) {
            Text("@AppStorage에 저장된 영화")
                .font(.system(size: 30, weight: .regular))
            Text("현재 저장된 영화: \(movieName)")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.red)
        }
        
    }
    
    
}

#Preview {
    MovieView()
}
