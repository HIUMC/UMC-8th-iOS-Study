//
//  StoreImageView.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/26/25.
//이것도 모야로 구현 (포토 레퍼런스는 모야로 구현x)
//사진타이밍 요청할때마다 불러오기 (요청 수를 줄이기)

// StoreImageView.swift

import SwiftUI
import Kingfisher

struct StoreImageView: View {
    let storeName: String
    @State private var imageURL: URL?

    var body: some View {
        Group {
            if let url = imageURL {
                KFImage(url) //kingfisher로 이미지 로딩
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Rectangle() //기존 이미지로 로딩
                    .fill(Color.gray)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onAppear {
                        fetchImageURL(for: storeName)
                    }
            }
        }
    }

    func fetchImageURL(for name: String) {
        let query = "스타벅스 \(name)" //쿼리 설정
        let encodedName = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiKey = APIKeys.googlePlaces
        //포토 레퍼런스 요청하는 url
        // 포토 레퍼런스 코드만 받아오는 urlString
        let urlString = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=\(encodedName)&inputtype=textquery&fields=photos&key=\(apiKey)"
     
        //문자열을 url로 바꿈
        guard let url = URL(string: urlString) else { return }

        //URLSession 사용해서 비동기 네트워크 요청을 보냄
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else { return }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               
               //구글은 최상위에 "candidates"라는 key를 가지고 있어서 가져오기
               let candidates = json["candidates"] as? [[String: Any]],
               
               //그중에 첫번째 사진 선택
               let first = candidates.first,
               
               //json 응답에 있는 photos 키로 이미지 정보 배열가져옴
               let photos = first["photos"] as? [[String: Any]],
               
               //첫번째 사진 photo_reference 꺼내오기
               let reference = photos.first?["photo_reference"] as? String {

                // 실제 사진을 보여주는 URL
                let photoURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(reference)&key=\(apiKey)"
                DispatchQueue.main.async {                                                              // 방금얻은 reference  // 내 apiKey
                    self.imageURL = URL(string: photoURL)
                }
            }
        }.resume()
    }
}
