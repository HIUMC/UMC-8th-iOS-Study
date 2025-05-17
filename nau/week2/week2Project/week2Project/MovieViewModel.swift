//
//  MovieViewModel.swift
//  week2Project
//
//  Created by nau on 3/20/25.
//

import Foundation
import SwiftUI

@Observable
class MovieViewModel {
    
    var currentIndex: Int = 0
    
    let movieModel : [MovieModel] = [
        .init(movieImage: Image(.image1), movieName: "미키", movieLike: 972, movieReserCount: 30.8),
        .init(movieImage: Image(.image2), movieName: "토이스토리", movieLike: 999, movieReserCount: 99.8),
        .init(movieImage: Image(.image3), movieName: "브루탈리스트", movieLike: 302, movieReserCount: 24.8),
        .init(movieImage: Image(.image4), movieName: "백설공주", movieLike: 302, movieReserCount: 3.8),
        .init(movieImage: Image(.image5), movieName: "위플래시", movieLike: 604, movieReserCount: 62.2),
        .init(movieImage: Image(.image6), movieName: "콘클라베", movieLike: 392, movieReserCount: 43.9),
        .init(movieImage: Image(.image7), movieName: "더폴", movieLike: 30, movieReserCount: 2.1)
    ]
    
    public func previousMovie() {
        currentIndex = (currentIndex - 1 + movieModel.count) % movieModel.count
    }
    
    public func nextMovie() {
        currentIndex = (currentIndex + 1 + movieModel.count) % movieModel.count
    }
    
}
