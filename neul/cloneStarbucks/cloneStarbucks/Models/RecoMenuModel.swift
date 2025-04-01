//
//  RecoMenuModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//

import SwiftUI

struct RecoMenuModel: Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    
    static let dummy: [RecoMenuModel] = [
        RecoMenuModel(imageName: "c1", title: "에스프레소 콘파나"),
        RecoMenuModel(imageName: "c2", title: "에스프레소 마끼아또"),
        RecoMenuModel(imageName: "c3", title: "아이스 카페 아메리카노"),
        RecoMenuModel(imageName: "c4", title: "카페 아메리카노"),
        RecoMenuModel(imageName: "c5", title: "아이스 카라멜 마끼아또"),
        RecoMenuModel(imageName: "c6", title: "카라멜 마끼아또")
    ]
}
