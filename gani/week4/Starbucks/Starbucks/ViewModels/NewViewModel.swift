//
//  NewViewModel.swift
//  Starbucks
//
//  Created by 이가원 on 4/7/25.
//

import Foundation

class NewViewModel: ObservableObject {
    @Published var newItems: [NewModel] = [
        NewModel(imageName: "new1", title: "그린 사이렌 도트 머그 \n 237ml"),
        NewModel(imageName: "new2", title: "그린 사이렌 도트 머그 \n 355ml"),
        NewModel(imageName: "new3", title: "홈 카페 미니 머그 세트"),
        NewModel(imageName: "new4", title: "홈 카페 글라스 세트"),
    ]
}
