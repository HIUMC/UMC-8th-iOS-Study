//
//  BreadAssetModelView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/3/25.
//


import Foundation

class BreadAssetViewModel: ObservableObject {
    @Published var breads: [BreadAssetModel] = [
        
        BreadAssetModel(name: "너티 크루아상", image: "nuttycroissant"),
        BreadAssetModel(name: "매콤 소시지 불고기", image: "spicysausagebulgogi"),
        BreadAssetModel(name: "미니 리프 파이", image: "minileafpie"),
        BreadAssetModel(name: "뺑 오 쇼콜라", image: "painauchocolat"),
        BreadAssetModel(name: "소시지&올리브 파이", image: "sausageolivepie")
        
    ]}
