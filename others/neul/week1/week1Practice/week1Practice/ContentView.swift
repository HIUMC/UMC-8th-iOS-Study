//
//  ContentView.swift
//  week1Practice
//
//  Created by tokkislove on 3/19/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}





struct ContentView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
