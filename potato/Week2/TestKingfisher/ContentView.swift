//
//  ContentView.swift
//  TestKingfisher
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI
import Kingfisher

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            if let url = URL(string: "https://i.namu.wiki/i/3nSn5PegM9JP0X7Utpo41q1inkR6FxEcHd9PuLGkohQD-yLEp9u4RvRaIqluD4eDrfBSxId99MFHTOCR7XVyONfOJVOUbHb-c4AV6MjMUoQ3y5lxp21M2NoJWmRjhyKuHJX6mh0K8FlQtX865P96RQ.webp") {
//                KFImage(url)
//                    .downsampling(size: CGSize(width: 400, height: 400))
//                    .placeholder({
//                        ProgressView()
//                            .controlSize(.mini)
//                    }).retry(maxCount: 2, interval: .seconds(2))
//                    .onFailure { error in
//                        print("이미지 로드 실패: \(error)")
//                    }
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 200, height: 200)
//            }
//            Text("경복궁입니다.")
//        }
//        .padding()
//    }
//}

struct ContentView: View {
    var body: some View {
        VStack {
            if let url = URL(string: "https://i.namu.wiki/i/3nSn5PegM9JP0X7Utpo41q1inkR6FxEcHd9PuLGkohQD-yLEp9u4RvRaIqluD4eDrfBSxId99MFHTOCR7XVyONfOJVOUbHb-c4AV6MjMUoQ3y5lxp21M2NoJWmRjhyKuHJX6mh0K8FlQtX865P96RQ.webp") {
                KFImage(url)
                    .setProcessors([DownsamplingImageProcessor(size: CGSize(width: 400, height: 400)), RoundCornerImageProcessor(radius: .heightFraction(0.5))])
                    .cacheOriginalImage()
                    .placeholder({
                        ProgressView()
                            .controlSize(.mini)
                    }).retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
            }
            Text("경복궁입니다.")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

