//
//  NewViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/4/25.
//

import Foundation
import SwiftUI

class NewViewModel: ObservableObject  {
    var Newname : [New] = [
        New(imageName: "new1", title: "그린 사이렌 도트 머그 \n 237ml"),
        New(imageName: "new2", title: "그린 사이렌 도트 머그 \n 355ml"),
        New(imageName: "new3", title: "홈 카페 미니 머그 세트"),
        New(imageName: "new4", title: "홈 카페 글라스 세트")
    ]
}
