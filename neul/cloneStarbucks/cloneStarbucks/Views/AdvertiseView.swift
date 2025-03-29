//
//  AdvertiseView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/29/25.
//

import SwiftUI

struct AdvertiseView: View {
    var body: some View {
        Image(.advertisement)
    }
}

struct AdvertiseView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            AdvertiseView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

