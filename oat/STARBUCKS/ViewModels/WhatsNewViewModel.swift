//
//  WhatsNew.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/28/25.
//

import Foundation
import SwiftUI

class WhatsNewViewModel: ObservableObject {
    var WhatNewMenu : [WhatsNew] = [
        WhatsNew(imageName: "noCup"),
        WhatsNew(imageName:"OOO"),
        WhatsNew(imageName:"28")
    ]
}
