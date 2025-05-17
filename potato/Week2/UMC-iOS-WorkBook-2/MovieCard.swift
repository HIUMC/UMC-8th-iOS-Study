//
//  MovieCard.swift
//  UMC-iOS-WorkBook-2
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI

struct MovieCard: View {
    let movieInfo: MovieModel
    
    init(movieInfo: MovieModel) {
        self.movieInfo = movieInfo
    }
    
    var body: some View {
        VStack(spacing: 5) {
            movieInfo.moiveImage
            
            Text(movieInfo.movieName)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.black)
            
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color.red)
                        .frame(width: 15, height: 14)
                    
                    Text("\(movieInfo.movieLike)")
                        .font(.system(size: 9, weight: .regular))
                        .foregroundStyle(Color.black)
                }
                
                Spacer()
                
                Text("예매율 \(String(format: "%.1f", movieInfo.movieReserCount))%")
                    .font(.system(size: 9, weight: .regular))
                    .foregroundStyle(Color.black)
            }
        }
        .frame(width: 120, height: 216)
    }
}

#Preview {
    MovieCard(movieInfo: .init(moiveImage: .init(.mickey), movieName: "미키", movieLike: 972, movieReserCount: 30.8))
}
