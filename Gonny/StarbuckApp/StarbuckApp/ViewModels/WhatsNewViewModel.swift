//
//  WhatsNewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//
//WhatsNewViewModel
import SwiftUI

    class WhatsNewViewModel: ObservableObject {
        @Published var adItems: [AdItem] = [
            AdItem(imageName: "ad1"),
            AdItem(imageName: "ad2"),
            AdItem(imageName: "ad3")
        ]
    }

