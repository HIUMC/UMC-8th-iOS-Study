//
//  MovieCard.swift
//  week2Lab
//
//  Created by tokkislove on 3/29/25.
//

import SwiftUI



// .init()을 통해 모델을 주입하여 내부 내용이 변경될 수 있도록 해야 함.
struct MovieCard: View {
    let movieInfo: MovieModel

    init(movieInfo: MovieModel) {
        self.movieInfo = movieInfo
    }
    
    var body: some View {
        VStack(spacing: 2) {
            movieInfo.movieImage
            Text(movieInfo.movieName)
                .font(.system(size: 20, weight: .bold))
            HStack {
                movieLike
                Spacer()
                Text("예매율 \(String(format: "%.1f", movieInfo.movieReserCount))%")
                    .font(.system(size: 9, weight: .regular))
            }
        }
        .frame(width: 120, height: 216)
    }
    
    private var movieLike: some View {
        HStack(spacing: 5) {
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.red)
                .frame(width: 15, height: 14)
            Text("\(movieInfo.movieLike)")
                .font(.system(size: 9, weight: .regular))
        }
    }
}



#Preview {
    MovieCard(movieInfo: .init(movieImage: .init(.mickey), movieName: "미키", movieLike: 972, movieReserCount: 30.8))
}
