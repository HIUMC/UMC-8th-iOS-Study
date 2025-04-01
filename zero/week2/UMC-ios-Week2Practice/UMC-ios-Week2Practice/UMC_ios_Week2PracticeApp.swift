//
//  UMC_ios_Week2PracticeApp.swift
//  UMC-ios-Week2Practice
//
//  Created by 김영택 on 3/26/25.
//

import SwiftUI

@main
struct UMC_ios_Week2PracticeApp: App {
    var body: some Scene {
        WindowGroup {
            MovieView()
            //MovieCard(movieInfo:  .init(movieImage: .init(.mickey), movieName: "미키", movieLike: 972, movieReserCount: 30.8))
        }
    }
}
