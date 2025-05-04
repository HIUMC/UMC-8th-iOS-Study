//
//  NewsModel.swift
//  Starbucks
//
//  Created by nau on 4/3/25.
//

import Foundation
import SwiftUI

struct NewsModel: Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var image: ImageResource
}
